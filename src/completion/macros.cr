macro completion(*fragments, &block)
  %completion = Completion::Completer.new File.basename $0
  %completion.set_fragments {{fragments}}
  {{block.args.first}} = %completion
  {{block.body}}
  %completion.init
end

macro completion(program, *fragments, &block)
  %completion = Completion::Completer.new {{program}}
  %completion.set_fragments {{fragments}}
  {{block.args.first}} = %completion
  {{block.body}}
  %completion.init
end
