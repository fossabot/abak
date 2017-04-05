# -*- encoding : utf-8 -*-
LOG_LEVEL = 4

#   1 - Creating a tree
#   2 - Adding Person to the Tree (Person Info, Index)
#   3 - Query keys

def log(txt, lvl)

	if lvl >= LOG_LEVEL

		p txt

	end

end

# class Person
class Person

	attr_reader :age, :height, :weight, :salary

	AGE_MAX = 100
	HEIGHT_MAX = 200
	WEIGHT_MAX = 200
	SALARY_MAX = 10**6

	def initialize(age, salary, height, weight)

		raise ValueError unless age.between?(0, AGE_MAX)
		@age = age

		raise ValueError unless salary.between?(0, SALARY_MAX)
		@salary = salary

		raise ValueError unless age.between?(0, HEIGHT_MAX)
		@height = height

		raise ValueError unless age.between?(0, WEIGHT_MAX)
		@weight = weight

	end

	def to_s

		"Person #{ @age } y/o [h: #{ @height }  w: #{ @weight }] have salary " +
			"#{ @salary }."

	end

	def get_by_alias(a)

		case a

		when "a"
			return @age
		when "h"
			return @height
		when "w"
			return @weight
		when "s"
			return @salary

		end

	end
 
	def index

		idx = ""

		data = [[AGE_MAX, @age], [HEIGHT_MAX, @height],
			[WEIGHT_MAX, @weight], [SALARY_MAX, @salary]]

		data.each do |param|

			idx += Person.index_param(param[1], param[0])

		end

		log("Index: #{ idx }", 2)

		idx

	end

	# @static
	def self.index_param(param, max)

		# Borders ASCII-Latin
		indexstartchr = 97
		indexendchr = 122

		# Group (character code) = val/(MAX/alphabet_len)
		step = max / (indexendchr - indexstartchr + 1)
		group = (param/step)

		# Correction for integer division
		if group > 25

			group = 25

		end

		idx = (group + indexstartchr).chr

	end

end

# class QueryParser
class QueryParser

	attr_reader :query

	def initialize(query)

		q = query.gsub("  ", "").gsub(" =", "=").gsub("= ", "=").split(" ")
		raise ValueError unless q.size < 5

		@query = {}

		q.each do |_q|

			# k=v => [k, v]
			_qs = _q.split("=")
			raise ValueError unless _qs.size == 2

			# n => [n], m..n => [m, n]
			v = _qs[1].split("..")
			raise ValueError unless v.size < 3

			# Not a number
			v.each do |_v|

				raise ValueError unless _v.to_i.is_a? Integer

			end

			raise ValueError unless "ahws".include?_qs[0] # No parameter
			raise ValueError unless !@query[_qs[0]] # Parameter repeat

			@query[_qs[0]] = v

		end

	end

	def to_s

		@query.to_s

	end

end

# class Node
class Node

	attr_accessor :key, :parent, :value, :childs

	def initialize(*args)

		@key = args[0]
		@parent = args[1]
		@value = []#args[2]
		@childs = args[3]

	end

	def to_s

		"#{ @parent } -> #{ @key }"

	end

end

# class Tree
class Tree

	def initialize

		log("Create Tree", 1)
		@root = Node.new("ROOT", nil, nil, [])
		init_tree(@root)

	end

	def alphabet

		(97..122).to_a.map{|n| n.chr}

	end

	# Initializes an empty branch with an empty set of child nodes
	def init_branch(node)

		alphabet.each do |s|

			node.childs.push(Node.new(s, node, nil, []))

		end

	end

	# Initializing the tree with empty branches
	def init_tree(node)

		i = 0
		t = node

		while t.parent
			i += 1
			t = t.parent

		end

		if i == 4

			log("Root reached", 1)
			return

		end

		# Recursively fills node.childs with nodes with keys, giving back the newly created
		# Node to fill in further. Exit from the recursion by the level of nesting = 4.
		log("Init #{ node }", 1)
		init_branch(node)
		log("Create childs of #{ node }", 1)
		node.childs.each do |n|

			log("Create childs for #{ n }", 1)
			init_tree(n)

		end

	end

	# From the values in the fields we build an index, and from the index we build a tree.
	# The index is formed as a sequence of Latin characters. Length = 4.
	# Each attribute can occupy only 1 index field, so the value can
	# Accept 1 of 26 letters.
	# 97-122: ord(a..z)
	def add(person)

		node = get(person.index)
		node.value.push(person)
		log(node, 2) 

	end

	# Passing through a tree to a node with a given key
	def get(key)

		node = @root
		key.each_char do |c|
			node = node.childs[c.ord - 97]

		end

		node

	end

	# Search for nodes on request. The symbol "*" means all the values in this position.
	# The final collection of the result is carried out on the lower level
	def extract(query)

		res = []

		# Generating traversal paths is a list of four-level keys for generating
		# All possible routes.
		path_list = [[], [], [], []]

		max = [Person::AGE_MAX, Person::HEIGHT_MAX, Person::WEIGHT_MAX,
			Person::SALARY_MAX]

		"ahws".each_char.with_index do |s, i|

			v = query.query[s]

			if v

				if v.size == 1

					path_list[i] = [Person.index_param(v[0].to_i, max[i])]

				else # size == 2

					l = Person.index_param(v[0].to_i, max[i])
					r = Person.index_param(v[1].to_i, max[i])
					path_list[i] = (l..r).to_a

				end

			else

				path_list[i] = alphabet

			end

		end

		log(path_list, 3)

		path_list[0].each do |z|

				path_list[1].each do |o|

					path_list[2].each do |t|

						path_list[3].each do |th|

							res.push(get(z + o + t + th))

						end

					end

				end

		end

		res

	end

end

# A wrapper for working with a tree and a search: adding and searching. class PersonPool
class PersonPool

	attr_reader :search_result, :last_query

	def initialize

		@search_result = []
		@last_query = ""
		@tr = Tree.new

	end

	def add(person)

		@tr.add(person)

	end

	def get(q)

		begin

			q = QueryParser.new(q.strip)
			@search_result = []
			@last_query = q

			# Selecting Person from a node array with groups
			@tr.extract(q).each do |person_node|
				person_node.value.each do |person|
					succ = true
					q.query.each do |k, v|
						p_v = person.get_by_alias(k)

						if v.size == 1

							if p_v != v[0].to_i

								succ = false

								break

							end

						else

							if p_v < v[0].to_i || p_v > v[1].to_i
								succ = false
								break

							end

						end

					end

					@search_result.push(person) if succ

				end

			end

		rescue

			@search_result = -1

		end

	end

	@search_result

end

# class Main
class Main

	def initialize

		qnt = 10**3
		puts "Generating #{ qnt } persons..."
		
		now = Time.now
		@persons = PersonPool.new
		puts "Tree created", Time.now - now

		now = Time.now

		qnt.times do

			@persons.add(Person.new(rand(Person::AGE_MAX), rand(Person::SALARY_MAX),
				rand(Person::HEIGHT_MAX), rand(Person::WEIGHT_MAX)))

		end

		puts "Objects created", Time.now - now
		puts
		puts "Print \"help\" to view commands"

		dialog

	end

	def dialog

		while true

			puts ">>"
			cmd = gets.strip.downcase

			case cmd

			when "exit"
				break
			when "last"
				puts @persons.last_query
			when "help"
				print_help
			when "print"
				print_result
			else

				now = Time.now
				@persons.get(cmd)

				# Just see how quickly it will appear
				sr = @persons.search_result

				puts "Search in #{ Time.now - now }s. Result: " +
					" #{ sr == -1? "Invalid query": sr.length }"

			end

		end

	end

	def print_help

		puts "Usage:"
		puts "\tparameters: [a]ge, [s]alary, [h]eight, [w]eight"
		puts "\tvalues: int[10], range(10..50)"
		puts "\tExample: a=30 h=50; s=10..20 w=30"
		puts "Commands:"
		puts "\texit: close program"
		puts "\thelp: print this text"
		puts "\tlast: print parsed last query"
		puts "\tresult: print search result"

	end

	def print_result

		if @persons.search_result == -1

			puts "Invalid query"

		else

			puts @persons.search_result

		end

	end

end

Main.new
# Finished
