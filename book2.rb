require 'date'

titles = [
    "デカルトの軌跡",
    "Ruby入門"
]

authors = [
    "佐藤 康行",
    "久保 秋"
]

yomis = [
    "さとうやすゆき",
    "くぼ あき"
]

publishers = [
    "講談社",
    "集英社"
]

pages = [
    1300,
    2500
]

prices = [
    1200,
    3000
]


purchase_prices = [
    2750,
    3300
]

sizes = [
    "21 x 14.8 x 2",
    "32 x 17 x 3"
]

publish_date = [
    Date.new(2015, 3, 1),
    Date.new(2018, 6, 20),
]

purchase_date = [
    Date.new(2019, 9, 3),
    Date.today
]

titles.length.times do |i|


puts <<~TEXT
    --------------------------------
    書籍名：#{titles[i]}
    著書名： #{authors[i]}
    読みがな：#{yomis[i]}
    出版社： #{publishers[i]}
    ページ数：#{pages[i]}
    販売価格：#{prices[i].to_s + "円"}
    購入費用：#{purchase_prices[i].to_s + "円"}
    寸法： #{sizes[i]}
    発刊日：#{publish_date[i]}
    購入日 #{purchase_date[i]}
    TEXT
end