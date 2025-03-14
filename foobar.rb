def foobar(n)
  for num in 1..n do
    ans = ""
    
    if num%3 == 0 then
      ans += "foo"
    end
    if num%5 == 0 then
      ans += "bar"
    end

    if ans != "" then
      puts ans
    else
      puts num
    end

  end
end