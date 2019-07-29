require'csv'
require 'gossip'
class Gossip
	attr_accessor :author, :content
	def initialize(author,content)
		@author = author
		@content = content

	end

	def save
  		CSV.open("./db/gossip.csv", "ab") do |csv|
    		csv << [@author,@content]
  		end
	end

	def self.all
  		all_gossips =[]

  		CSV.read("db/gossip.csv").each do |csv_line|
    		all_gossips << Gossip.new(csv_line[0],csv_line[1])
  		end
  	return all_gossips
	end
	  def self.find(id)
    gossip = []
    CSV.read("db/gossip.csv").each_with_index do |csv_line, n|
      if id - 1 == n # les potins commencent à 0
        gossip << Gossip.new(csv_line[0], csv_line[1])
      end
    end
    return gossip
  end

  def edit(id)
    all_gossips = [] # récup du csv sous forme de tableau
    CSV.read("db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end

    all_gossips.each_with_index do |gossip, i|
      if id-1 == i # si l'id correspond au numéro de ligne on modifie l'index du tableau
        all_gossips[i] = Gossip.new(@author, @content)
      end
    end

    CSV.open("db/gossip.csv", "wb") do |csv| # réécriture tout le csv à partir du tableau modifié
      all_gossips.each do |gossip|
        csv << [gossip.author, gossip.content]
      end
    end

  end

  def self.read_comments(id)
    all_comments = []
    if File.file?("db/comments#{id}.csv")
      CSV.open("db/comments#{id}.csv", "r").each do |csv_line|
      all_comments << csv_line
      end
      return all_comments
    end
    return nil
  end

  def self.add_comment(id, content)
    CSV.open("db/comments#{id}.csv", "ab") do |csv|
      csv << [content]
    end
  end

end
