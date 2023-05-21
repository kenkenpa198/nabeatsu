#!/usr/bin/env ruby

# 検証エラーの際に出力する文字列を初期化
EXAMPLE = "\nexample:\n  $ ruby nabeatsu 12"

# 与えられた配列の数が 1 以外だった場合は処理を終了するメソッド
def validate_args_number(given_args_number)
  if given_args_number.length != 1
    puts "[ERROR] wrong number of arguments (given #{given_args_number.length}, expected 1)"
    puts EXAMPLE
    exit
  end
end

# 与えられた引数が整数でない場合は処理を終了するメソッド
def is_numeric(num)
  if !num.is_a?(Integer)
    puts "[ERROR] argument is not Integer"
    puts EXAMPLE
    exit
  end
end

# 与えられた引数が 0 以下の場合は処理を終了するメソッド
def validate_under_zero(num)
  if num <= 0
    puts "[ERROR] argument is under zero. Please give a positive number"
    puts EXAMPLE
    exit
  end
end

# 桁に 3 を含むか評価するメソッド
def has_three_digits(num)
  # num の桁数を計算して初期化
  # log10 (絶対値) の結果を整数に変換後 1 を加えると桁数となる
  # https://www.fenet.jp/dotnet/column/language/3851/
  # 例) num が 1234 の場合は 4 を number_of_digits へ代入する
  number_of_digits = Math.log10(num.abs).to_i + 1

  # 桁の重みを計算して初期化
  # 10^(桁数 - 1) が桁の重みとなる
  # 例) number_of_digits が 4 の場合、1000 を weight へ代入する
  weight = 10**(number_of_digits - 1)

  # 桁数分だけ評価を繰り返す
  number_of_digits.times {
    # num を桁の重みで割り、商が 3 であれば true を返してメソッドの処理を終了する
    # 商が 3 でなければ桁と重みをひとつ減らして次のループへ移る
    #
    # 例)
    # num が 1234, number_of_digits が 4, weight が 1000 を初期値とした場合
    # 1 ループ目 | 1234 / 1000 の商は 1 → 偽として評価。num を 234, weight を 100 にして次のループへ
    # 2 ループ目 |  234 /  100 の商は 2 → 偽として評価。num を  34, weight を  10 にして次のループへ
    # 3 ループ目 |   34 /   10 の商は 3 → 真として評価。true を返して処理を終了する
    if num / weight == 3
      return true
    else
      # 偽の場合は次のループで評価する値を num へ再代入する

      # チェック済みの桁を num から削除する
      # 例) 1234 → 234
      delete_digits = num / weight * weight
      num           = num - delete_digits

      # 桁の重みを 1 つ減らす
      # 例) 1000 → 100
      weight = weight / 10
    end
  }

  # 3 を含む桁が存在せずループを抜けた場合は false を返す
  return false
end

# 整数が 3 で割り切れる または いずれかの桁に 3 を含む場合 true を返すメソッド
def is_nabeatsu(num)
  # 整数が 3 で割り切れる または いずれかの桁に 3 を含む場合 true を出力する
  if num % 3 == 0 || has_three_digits(num)
    return true
  else
    return false
  end
end

# このファイルが直接実行された場合にのみ実行する処理
if __FILE__ == $0
  # 与えられたコマンドライン引数の数が 1 以外だった場合は処理を終了する
  validate_args_number(ARGV)

  # 文字列として受け取ったコマンドライン引数を整数へ変換する
  num = ARGV[0].to_i

  # 与えられた引数が整数でない場合は処理を終了する
  # validate_integer(num)

  # 与えられた引数が 0 以下の場合は処理を終了する
  # 引数の最初の文字が数値でなかった場合も含む (to_i での変換時に文字列は 0 へ変換されるため)
  validate_under_zero(num)

  # is_nabeatsu メソッドを実行する
  # true の場合は「num!!!」と出力する
  if is_nabeatsu(num)
    puts "#{num}!!!"
  else
    puts "#{num}"
  end
end
