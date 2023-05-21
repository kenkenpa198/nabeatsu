#!/usr/bin/env ruby

# 検証エラーの際に出力する文字列を初期化
EXAMPLE = "\nexample:\n  $ ruby nabeatsu 12"

# 引数の数を検証する
if ARGV.length == 0
  puts "引数へ与えられた整数が 3 で割り切れる または いずれかの桁に 3 を含む場合 [num]!!! と出力します。"
  puts EXAMPLE
  exit
elsif ARGV.length != 1
  puts "コマンドライン引数はひとつだけ指定して実行してください"
  puts EXAMPLE
  exit
end

# 文字列として受け取った引数を整数へ変換する
num = ARGV[0].to_i

# ～～ ここから num は文字列へ変換禁止の縛り ～～

# 0 へ変換された場合はエラーメッセージを返す
# 引数が 0 だった場合や引数の最初の文字が数値でなかった場合が対象となる
if num == 0
  puts "コマンドライン引数は 1 以上の整数を指定して実行してください"
  puts EXAMPLE
  exit
end

def has_three(num)
  # num の桁数を計算して初期化
  # log10 (絶対値) の結果を整数に変換後 1 を加えると桁数となる
  # https://www.fenet.jp/dotnet/column/language/3851/
  # 例) num が 1234 の場合は 4 を number_of_digits へ代入する
  number_of_digits = Math.log10(num.abs).to_i + 1

  # 桁の重みを計算して初期化
  # 10^(桁数 - 1) が桁の重みとなる
  # 例) number_of_digits が 4 の場合、1000 を weight へ代入する
  weight = 10**(number_of_digits - 1)

  # prev_weight を初期化
  prev_weight = weight * 10

  number_of_digits.times {
    # 前回ループでチェック済みの桁を削除する
    check_num = num - num / prev_weight * prev_weight
    puts "---"
    puts check_num
    puts check_num / weight

    # num を桁の重みで割り、商が 3 であれば true を返して終了する
    # 商が 3 でなければ重みをひとつ減らして次のループへ移る
    #
    # 例)
    # num が 1234 の場合 number_of_digits は 4, weight は 1000 となる
    # 1 ループ目 | 1234 / 1000 の商は 1 → 偽として weight を 100 にして次のループへ
    # 2 ループ目 |  234 /  100 の商は 2 → 偽として weight を  10 にして次のループへ
    # 3 ループ目 |   34 /   10 の商は 3 → 真として true を返して終了
    if check_num / weight == 3
      return true
    else
      prev_weight = weight
      weight = weight / 10
    end
  }

  # ループを抜けた場合は false を返す
  return false
end

# 整数が 3 で割り切れる または いずれかの桁に 3 を含む場合「num!!!」と出力する
if num % 3 == 0 || has_three(num)
  puts "#{num}!!!"
else
  puts "#{num}"
end