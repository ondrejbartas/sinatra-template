# -*- encoding : utf-8 -*-
class Overseer
  
  def test
    node = Munin::Node.new('blade106.internal.ataxo.cz', 4949)
    cpu = node.fetch('cpu')["cpu"]
    memory = node.fetch('memory')
    node.disconnect

    pp cpu
    maximal = cpu.inject(0){|o,i| o+i.last.to_i}
    pp cpu.inject({}){|o,i| o[i.first] = (i.last.to_f / maximal.to_f * 100.0).round(2); o }
    pp memory["memory"].inject({}){|o,i| o[i.first] = i.last.to_f/1024.0/1014.0; o }
  end
end