macro completion(*fragments, &block)
  %completion = Completion::Completer.new File.basename $0
  %completion.set_fragments [{{*fragments}}]
  {{block.args.first}} = %completion
  {{block.body}}
  %completion.init
end

macro complete_with(parser)
  %options = [] of String
  {{parser}}.to_s.split("\n").each do |v|
    res = v.match(/\s{4}(.*?)\s{2}/)
    if (res != nil)
      opts = res.not_nil![1].split(",").map do |e|
        e.split(/\s+/, 1).not_nil!.map do |v|
          %options << v.gsub(/^\s+|\s+$/, "").split(/\=|\s/)[0]
        end
      end
    end
  end

  %completion = Completion::Completer.new File.basename $0
  %completion.set_fragments [:__opts]
  %completion.on(:__opts) do
    %completion.reply %options
  end
  %completion.end do
    %completion.reply %options
  end
  %completion.init
end

macro completion(program, *fragments, &block)
  %completion = Completion::Completer.new {{program}}
  %completion.set_fragments [{{*fragments}}]
  {{block.args.first}} = %completion
  {{block.body}}
  %completion.init
end

macro complete_with(program, parser)
  %options = [] of String
  {{parser}}.to_s.split("\n").each do |v|
    res = v.match(/\s{4}(.*?)\s{2}/)
    if (res != nil)
      opts = res.not_nil![1].split(",").map do |e|
        e.split(/\s+/, 1).not_nil!.map do |v|
          %options << v.gsub(/^\s+|\s+$/, "").split(/\=|\s/)[0]
        end
      end
    end
  end

  %completion = Completion::Completer.new {{program}}
  %completion.set_fragments [:__opts]
  %completion.on(:__opts) do
    %completion.reply %options
  end
  %completion.end do
    %completion.reply %options
  end
  %completion.init
end
