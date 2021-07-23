require 'date'
require 'rubygems'
require 'dbi'
require 'date'

class BookInfo

    attr_accessor :title, :author, :page, :publish_date

    #BookInfoクラスのインスタンスを初期化
    def initialize(title, author, page, publish_date)
        @title = title
        @author = author
        @page = page
        @publish_date = publish_date
    end

    def to_s
        "#{@title}, #{@author}, #{@page}, #{@publish_date}" 
    end

    def toFormattedString
        puts <<~TEXT
        --------------------------------
        書籍名：#{@title}
        著書名： #{@author}
        ページ数：#{@page}
        発刊日#{@publish_date}
        TEXT
    end
end

class BookInfoManager
    def initialize(sqlite_name)
        @book_infos = {}
        #SQLite3データベースへ接続
        @db_name = sqlite_name
        @dbh = DBI.connect( "DBI:SQLite3:#{@db_name}" ) 
    end

    #データベースを初期化
    def initBookInfo
        puts "0.データベースの初期化"
        print "初期化しますか？(Y/yなら削除を実行します)："
        #読み込んだ文字を大文字へ変換
        result = gets.chomp.upcase
        if /^Y$/ =~ result
            #Yが一文字だけの時に初期化

            #データベースに'book_infosテーブルがあれば削除する
            @dbh.do("drop table if exists bookinfos")

            @dbh.do("create table bookinfos (
                id            varchar(50)  not null,
                title         varchar(100) not null,
                author        varchar(100) not null,
                page          int          not null,
                publish_date  datetime     not null,
                primary       key(id)
                );
            ")
        end
    end


    #データを登録する
    def addBookInfo

        puts "蔵書データの登録"
        print "蔵書データを登録します"

        #蔵書データ１件分のインスタンシを生成
        @book_info = BookInfo.new("", "", 0, Date.new)

        #項目ごとに登録データを入力
        print "¥n"
        print "キー: "
        key = gets.chomp
        print "書籍名: "
        @book_info.title = gets.chomp
        print "著書名: "
        @book_info.author = gets.chomp
        print 'ページ数: '
        @book_info.page = gets.chomp
        print '発刊年 '
        year = gets.chomp.to_i
        print '発刊月 '
        month = gets.chomp.to_i
        print '発刊日 '
        day = gets.chomp.to_i
        @book_info.publish_date = Date.new( year, month, day )

        #作成した蔵書データの１件分をハッシュに登録する
        #@book_infos[key] = @book_info

        #作成したデータ１件をデータベースへ登録
        @dbh.do("insert into bookinfos values(
            '#{key}',
            '#{@book_info.title}',
            '#{@book_info.author}',
            '#{@book_info.page}',
            '#{@book_info.publish_date}'
            );")
        
        puts "¥n登録しました"
    end

    #蔵書データの一覧を表示させる
    def listAllBooks
        item_name = {'id' => 'キー', 'title' => '書籍のタイトル', 'author' => '作者', 'page' => 'ページ数', 'publish_date' => '発刊日'}

        puts "2. 蔵書データの表示"
        print "¥n---------------"

        #テーブルからデータを読み込んで表示させる
        sth = @dbh.execute("select * from bookinfos")

        # select文の実行結果を１件ずつrowに取り出し、繰り返し処理をする
        counts = 0
        sth.each do |row|
            #rowは１件分のデータを保持している
            row.each_with_name do |val, name|
                puts "#{item_name[name]}：#{val.to_s}"
            end

            puts "----------------"
            counts += 1
        end

        #実行結果を解放する
        sth.finish

        puts "¥n#{counts}件表示しました"
    end

     #処理の選択と選択後の処理を繰り返す
    def run

        while true
            #機能選択画面を表示する
            print "
            0. 蔵書データベースの作成
            1. 蔵書データの登録
            2. 蔵書データの表示
            9.終了
            番号を選択してください(0,1,2,9):"

            num = gets.chomp
            case 
            when '0' == num
                #蔵書データの初期化
                initBookInfo
            when '1' == num
                #データの登録
                addBookInfo
            when '2' == num
                #データの表示
                listAllBooks
            when '9' == num
                #データベースとの接続を終了する
                @dbh.disconnect

                puts "¥n終了しました"
                break;
            else
                #処理待ち画面へ戻る
            end
        end
    end

end

#アプリケーションを動かす本体

book_info_manager = BookInfoManager.new("bookinfo_sqlite.db")
book_info_manager.run


