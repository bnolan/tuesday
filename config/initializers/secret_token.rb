# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Cms::Application.config.secret_key_base = 'e93a15f2a212923ec37e3db2fc1a6cca9c099a1198eba01c721bf946edad956e28e39500bcdf73ce799ca3ea1c60f75ae54e165bafe02d050910bfeb0cd0bbe8'
