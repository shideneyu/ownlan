module Ownlan
  class Exception < StandardError; end
  class MissingArgumentError < Exception; end
  class VictimNotReachable < Exception; end
  class WrongVictimIpFormat < Exception; end
  class WrongInterace < Exception; end
  class NotRoot < Exception; end
end
