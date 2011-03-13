# from http://railsdog.com/blog/2011/02/22/cucumber-testing-tips/
After do |scenario|
  if scenario.failed?
    puts "\nScenario failed. Type exit when you are done"
    require 'ripl'
    Ripl.start :binding => instance_eval { binding }, :irbrc => false
  end
end
