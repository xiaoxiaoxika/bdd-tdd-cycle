
Given(/^the following movies exist:$/) do |table|
  table.hashes.each {|movie| Movie.create!(movie)}
end

Then(/^the director of "(.*?)" should be "(.*?)"$/) do |arg1, arg2|
   content = page.body
   content.index(arg1).should <= content.index(arg2) if content.include?(arg1) & content.include?(arg2)
end






