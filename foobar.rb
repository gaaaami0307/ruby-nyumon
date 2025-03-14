def foobar(n)
  ans = ""
  
  if n%3 == 0 then
    ans += "foo"
  end
  if n%5 == 0 then
    ans += "bar"
  end

  if ans != "" then
    puts ans
  else
    puts n
  end
end

foobar(15);