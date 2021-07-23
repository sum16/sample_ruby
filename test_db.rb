#DBIを用いてsqllite3を操作する

require 'rubygems'

require 'dbi'

dbh = DBI.connect( 'DBI:SQLite3:students.db' )




#dbh.select_all('select * from students') do | row |
    # SQL[select * from students ]を実行し、
    # 1行ずつ受け取って、ブロックを処理する
    #STDOUT.print "row=#{row}           \n"
    #STDOUT.print "  name = #{row[0]}\n"
    #STDOUT.print "  age  = #{row[1]}\n"
#end