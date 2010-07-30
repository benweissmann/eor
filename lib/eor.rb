Dir[File.join(File.dirname(__FILE__), 'eor', '**', '*.rb')].each {|f| require f}

class Proc
  def eor *args, &block
    args.unshift self
    args.push block
    return EOr.new.eor(args)
  end
end

class EOr
  def eor procs, args=[]
    begin
      return value_of procs.shift, args
    rescue Exception => e
      return eor(procs, args.push(e))
    end
  end
  
  private
  
  def value_of o, args
    if o.kind_of? Proc
      return o.call *args
    else
      return o
    end
  end
end
