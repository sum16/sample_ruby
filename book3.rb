require 'date'

class BookInfo

    attr_accessor :title, :author, :page, :publish_date

    def initialize(title, author, page, publish_date)
        @title = title
        @author = author
        @page = page
        @publish_date = publish_date
    end

    def to_s
        "#{@title}, #{@author}, #{@page}, #{@publish_date}" 
    end

    def toFormattedString(book_info)
        puts <<~TEXT
        --------------------------------
        書籍名：#{book_info.title}
        著書名： #{book_info.author}
        ページ数：#{book_info.page}
        発刊日#{book_info.publish_date}
        TEXT
    end
end

book_infos = Hash.new
book_infos["book01"] = BookInfo.new(
    "アジャイル開発の基礎",
    "山田　正樹",
    248,
    Date.new(2005, 1,25)
)

book_infos["book02"] = BookInfo.new(
    "Ruby入門",
    "久保秋　真",
     500,
    Date.new(20011, 11,6)
)


book_infos.each do |key, value|
    puts "#{key} : #{value}"
end





