require 'net/https'

class Net::HTTP
  def self.post(uri, data, header)
    __post_or_put__(:post, uri, data, header)
  end

  def self.put(uri, data, header)
    __post_or_put__(:put, uri, data, header)
  end

  def self.__post_or_put__(method, uri, data, header)
    uri = URI.parse(uri)
    i = new(uri.host, uri.port)
    unless uri.port == 80
      i.use_ssl = true
      i.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    i.__send__(method, uri.path, data, header)
  end
end

# sample code
#    a = Net::HTTP.post(
#      'https://www.google.com/accounts/ClientLogin',
#      {
#        'Email' => email,
#        'Passwd' => pass,
#        'service' => 'blogger',
#        'accountType' => 'HOSTED_OR_GOOGLE',
#        'source' => 'ujihisa-bloggervim-1'
#      }.map {|i, j| "#{i}=#{j}" }.join('&'),
#      {'Content-Type' => 'application/x-www-form-urlencoded'})
#    a.body.lines.to_a.maph {|i| i.split('=') }['Auth'].chomp
