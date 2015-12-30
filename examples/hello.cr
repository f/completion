require "../src/completion"

completion :where do |comp|
  comp.on(:where) do
    comp.reply ["world", "mars", "pluton"]
  end
end
