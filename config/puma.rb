ENV['RACK_ENV'] ||= 'development'
environment ENV['RACK_ENV'] || 'production'

if ENV['RACK_ENV'] != 'production'
  CERT_PATH = File.expand_path(__dir__)

  ssl_bind '0.0.0.0', '3001', {
    key: File.join(CERT_PATH, 'server.key'),
    cert: File.join(CERT_PATH, 'server.crt'),
    verify_mode: 'none'
  }
end
