require 'open-uri'
require "nokogiri"

APPID = 'dj0zaiZpPUV3QnBoMjVPS25WOSZzPWNvbnN1bWVyc2VjcmV0Jng9MDg-'
REQUEST_URL = "http://jlp.yahooapis.jp/MAService/V1/parse"

module Morphological
  extend self
  def split(sentence, appid=APPID, results="ma", filter="1|2|3|4|5|9|10")
    params = "?appid=#{APPID}&results=#{results}&filter=#{URI.encode(filter)}&sentence=#{URI.encode(sentence)}"
    doc = Nokogiri::HTML(open(REQUEST_URL + params)) # htmlをパース(解析)してオブジェクトを生成 openはurlを普通のファイルのように開けるようにすること 
    surfaces = doc.xpath('//word/surface').map{|i| i.text} rescue nil
    surfaces
  end
end