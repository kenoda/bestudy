#対数とかを扱うために数学的なことができるようなgemが必要みたい
include Math
require 'set'

require_relative "morphological"

# lecture1 =Bfilter.new
# doc ="真面目に勉強している"
# lecture1.train(doc, "A")
# lecture1.classifier("テックキャンプでやっているよ") => B

def getwords(doc)
  Morphological::split(doc)
end


class Bfilter

  def initialize #最初に空の配列を配置
    @vocabularies = Set.new #Set.newは{}と同義 Set.new[1.2]はset{1,2}と同じ Hashをストレージとして使う 集合を表すクラス http://docs.ruby-lang.org/ja/2.1.0/class/Set.html
    @wordcount = {}
    @catcount = {}
  end

  # 与式＝p(cat|doc)=p(doc|cat)p(cat)/p(doc)
  # ただし分母は一定なので、p(doc)は無視
  # ゆえに、与式はp(doc|cat)p(cat)に比例
  # p(cat)=カテゴリが与えられた回数/総文書数
  # p(doc|cat)=p(word1|cat)p(word2|cat)...p(wordn|cat)なぜなら、ナイーブベイズは独立性を仮定しているから
  # p(wordn|cat)=あるカテゴリにwordnが分類された回数/カテゴリに出現した全単語数


  #訓練：カテゴリkにワードkが分類された回数 or カテゴリにwordn(各単語)が分類された回数を保存
  # 二次元配列を作成 catが行,wordが列
  def wordcountup(word, cat)
    @wordcount[cat] ||= {} #空のcat名のついた行を作成
    @wordcount[cat][word] ||= 0 #catのwordnを作成し０を挿入
    @wordcount[cat][word] += 1 #1を追加
    @vocabularies.add(word) #<<と同様
  end

  #各カテゴリの登場回数 p(cat)の分子に使用
  def catcountup(cat)
    @catcount [cat] ||= 0
    @catcount[cat] += 1
  end

  #each文つかってそれぞれの行や列に挿入するだけ
  def train(doc, cat)
    word = getwords(doc)
    word.each do |w|
      wordcountup(w, cat)
    end
    catcountup(cat)
  end

  #p(cat)=カテゴリが与えられた回数/総文書数 総カテゴリ数でない理由は一つの文書に複数のカテゴリが与えられる可能性もあるから @catcaount[cat]はあるカテゴリcatの数
  def priorprob(cat)
    prob = @catcount[cat] / @catcount.values.inject(:+).to_f
    prob
    #.to_fは文字列を不動小数点に変換するもの
    #values ハッシュのキーの値を集めて配列にして返す つまり各カテゴリに入っている文字の回数を返す
    # 例）scores = { "Alice" => 50, "Bob" => 60, "Carol" => 90, "David" => 40 }
    # =>[50, 60, 90, 40]
    #  http://ref.xaio.jp/ruby/classes/hash/values
    # inject: ハッシュになったものを、それぞれinjectの中に入れ込んで合計を出すことができる
    # sum = [1, 2, 3, 4, 5].inject(:+)   => 15 http://akisute3.hatenablog.com/entry/20111122/1322153061
  end

  # 同時確率p(wordn,cat) p(wordn|cat)=p(wordn,cat)/p(cat)の分子 あるカテゴリの中に単語が登場した回数=あるカテゴリを観測したときにある単語が登場する回数
  def incategory(word, cat)
    return @wordcount[cat][word].to_f if @wordcount[cat].key? word #keyがあったときのみ返す
    0 #なければ0を返す
  end

  #p(wodn|cat)を求める=>p(wordn, cat)/p(cat)のはずだが、ここでゼロ頻度問題を解決するために、分子に+1、分母に単語数を加える。これをラプラススムージングという http://aidiary.hatenablog.com/entry/20100613/1276389337
  def wordprob(word, cat)
    (incategory(word, cat) + 1.0) / (@wordcount[cat].values.inject(:+) + @vocabularies.length)
    # prob = (incategory(word, cat) + 1.0) / (@wordcount[cat].values.inject(:+) + @vocabularies.length * 1.0) #かける１いらないでしょ
    # prob
  end

  #p(doc|cat)∝p(doc|cat)p(cat)
  # p(doc|cat)=Π p(wordn|cat) 非常に小さい値になってしまいアンダーフローを起こす可能性があるので、対数に変換する =>p(doc|cat)=Σlog p(wordn|cat)
  def score(word, cat)
    score = Math.log(priorprob(cat)) #log p(cat)
    word.each do |w|
      score += Math.log(wordprob(w, cat))
    end
    score
  end

  #カテゴリの推定：分類 p(word|doc)
  def classifier(doc)
    best = nil
    max = -2147483648
    #整数型でサポートされる、最大の整数の値は最低でも 2**31-1 です。最大の負数は -maxint-1 となります。正負の最大数が非対称ですが、これは 2 の補数計算を行うため
    word = getwords(doc)

    @catcount.keys.each do |cat|
      prob = score(word, cat)
      if prob >max
        max = prob
        best = cat
      end
    end
    best
  end
end

