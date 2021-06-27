-- bitshift functions (<<, >> equivalent)
-- shift left
function lsh(value,shift)
	return (value*(2^shift))
end

-- shift right
function rsh(value,shift)
	return math.floor(value/2^shift)
end

-- return single bit (for OR)
function bit(x,b)
	return (x % 2^b - x % 2^(b-1) > 0)
end

-- logic OR for number values
function lor(x,y)
	result = 0
	for p=1,32 do result = result + (((bit(x,p) or bit(y,p)) == true) and 2^(p-1) or 0) end
	return result
end

-- logic AND for number values
function land(x,y)
	result = 0
	for p=1,32 do result = result + (((bit(x,p) and bit(y,p)) == true) and 2^(p-1) or 0) end
	return result
end

-- floor division
function dv(x, y)
    return math.floor(x/y)
end

-- encryption table
local base64chars = {[0]='A',[1]='B',[2]='C',[3]='D',[4]='E',[5]='F',[6]='G',[7]='H',[8]='I',[9]='J',[10]='K',[11]='L',[12]='M',[13]='N',[14]='O',[15]='P',[16]='Q',[17]='R',[18]='S',[19]='T',[20]='U',[21]='V',[22]='W',[23]='X',[24]='Y',[25]='Z',[26]='a',[27]='b',[28]='c',[29]='d',[30]='e',[31]='f',[32]='g',[33]='h',[34]='i',[35]='j',[36]='k',[37]='l',[38]='m',[39]='n',[40]='o',[41]='p',[42]='q',[43]='r',[44]='s',[45]='t',[46]='u',[47]='v',[48]='w',[49]='x',[50]='y',[51]='z',[52]='0',[53]='1',[54]='2',[55]='3',[56]='4',[57]='5',[58]='6',[59]='7',[60]='8',[61]='9',[62]='-',[63]='_'}

-- encodes 32 byte array to 43 base64 string - magic
-- data must have 32 bits
function encode0(data)
    src = {}
    for i = 0, 64, 1 do
        if i <= 31 then
            src[i] = data[i+1]
        else 
            src[i] = 0
        end
    end
    
    dst = ""
    sp = 0
    slen = 32
    sl = 32
    dp = 0
    size = 43

    while sp < sl do
        sl0 = math.min(sp + slen, sl)

        sp0 = sp
        dp0 = dp
        while(sp0 < sl) do
            p0 = lsh(land(src[sp0], 0xff), 16)
            p1 = lsh(land(src[sp0+1], 0xff), 8)
            p2 = land(src[sp0+2], 0xff)
            bits = lor(p0, lor(p1, p2))

            dst = dst .. base64chars[ land(rsh(bits, 18), 0x3f) ]
            dp0 = dp0+1
            dst = dst .. base64chars[ land(rsh(bits, 12), 0x3f) ]
            dp0 = dp0+1
            dst = dst .. base64chars[ land(rsh(bits, 6), 0x3f) ]
            dp0 = dp0+1
            if(dp0 >= size) then -- magic2
                break
            end
            dst = dst .. base64chars[ land(bits, 0x3f) ]
            dp0 = dp0+1

            sp0 = sp0+3
        end


        dlen = dv((sl0 - sp), 3) * 4
        dp = dp + dlen 
        sp = sl0
    end

    if(sp < 32) then
        b0 = land(src[sp], 0xff)
        dst = dst .. base64chars[rsh(b0, 2)]

        if sp == 32 then
            dst = dst .. base64chars[land(lsh(b0, 4), 0x3f)]
        else
            b1 = land(src[sp], 0xff)
            sp = sp+1

            dst = dst .. base64chars[lor(land(lsh(b0, 4), 0x4f), rsh(b1, 4))]
            dst = dst .. base64chars[land(lsh(b1, 2), 0x3f)]
        end
    end

    return dst
end

return {
    encode0 = encode0,
}