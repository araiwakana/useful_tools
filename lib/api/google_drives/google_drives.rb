#ruby標準添付ライブラリ
require 'openssl'
OpenSSL::SSL.module_eval{ remove_const(:VERIFY_PEER) }
OpenSSL::SSL.const_set( :VERIFY_PEER, OpenSSL::SSL::VERIFY_NONE )

#bundlerでinstallしたgemをすべてrequire
require 'bundler'
Bundler.require

#他のクラス(読み込む順番大事)
require_relative "constants"
require_relative "base"