# net/https wrapper

    require 'net-https-wrapper'

    a = Net::HTTP.post(
      'https://www.google.com/accounts/ClientLogin',
      {
        'Email' => email,
        'Passwd' => pass,
        'service' => 'blogger',
        'accountType' => 'HOSTED_OR_GOOGLE',
        'source' => 'ujihisa-bloggervim-1'
      }.map {|i, j| "#{i}=#{j}" }.join('&'),
      {'Content-Type' => 'application/x-www-form-urlencoded'})
    a.body.lines.to_a.maph {|i| i.split('=') }['Auth'].chomp
