module Faalis
  module Comments
    class Engine < ::Rails::Engine
      isolate_namespace Faalis::Comments

      engine_name 'faalis_tags'
    end
  end
end
