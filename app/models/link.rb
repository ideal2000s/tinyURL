# frozen_string_literal: true

class Link < ApplicationRecord # rubocop:disable Style/Documentation
  validates :original_url, presence: true

  after_create :create_short_url

  def create_short_url
    self.short_url = url_encode(id)
    save
  end

  private

  def url_encode(id)
    return alphabet[0] if id.zero?

    s = ''
    base = alphabet.length
    while id.positive?
      s << alphabet[id.modulo(base)]
      id /= base
    end
    s.reverse
  end

  def alphabet
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.split(//)
  end
end
