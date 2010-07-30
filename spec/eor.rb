require 'lib/eor'

describe Proc, '#eor' do
  it "should return the result of a successful Proc" do
    proc{ 'hi' }.eor.should == 'hi'
  end
  
  it "should return nil for a failed Proc" do
    proc{ fail }.eor.should be_nil
  end
  
  it "should return the result of a second proc if the first fails" do
    proc{ fail }.eor(proc{ 10 }).should == 10
  end
  
  it "should return the result of the first proc if it is successful, even if there are alternatives" do
    proc { :foo }.eor(proc{ 10 }).should == :foo
  end
  
  it "should accept a block" do
    r = proc { not_a_method }.eor do
      3.14
    end
    
    r.should == 3.14
  end
  
  it "should accept a non-proc value" do
    proc { not_a_method }.eor("foo").should == "foo"
  end
  
  it "should return nil if two procs fail" do
    proc { not_a_method }.eor(proc {10 / 0}).should be_nil
  end
  
  it "should accept many procs" do
    proc { not_a_method }.eor(proc { 10 / 0 }, proc { system }, 'foo').should == "foo"
  end
  
  it "should stop processing after a successful proc" do
   proc { not_a_method }.eor(proc {10 / 0 }, proc { 'foo' }, proc { $foo = true }).should == "foo"
   $foo.should be_nil
  end
  
  it "should return the first good value" do
    proc { not_a_method }.eor(proc {10 / 0 }, proc { 'foo' }, proc { " " }).should == "foo"
  end
  
  it "should return nil for many bad values" do
    proc { not_a_method }.eor(proc {10 / 0 }, proc { system }).should be_nil
  end
  
  it "should provide the errors, in order" do
    a, b, c = proc { not_a_method }.eor(proc {10 / 0 }, proc { system }, proc {|a, b, c| [a, b, c]})
    
    a.should be_an_instance_of NameError
    b.should be_an_instance_of ZeroDivisionError
    c.should be_an_instance_of ArgumentError
  end
end

describe EOr, "::EOR_VERSION" do
  it "should be a string" do
    EOr::EOR_VERSION.should be_an_instance_of String
  end
end
