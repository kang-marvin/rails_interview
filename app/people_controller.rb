
class PeopleController	
# include ParseDisplay
  def initialize(params)
    @params = params
  end

  def normalize
  	p @params
  	list_key=["first_name","city","birthdate"]

  	p=Parse.new()
  	dollar = p.parse(params[:dollar_format])
  	percent = p.parse(params[:percent_format])
  	final = dollar + percent

  	s=Sort.new()
  	s.display(final,params[:order].to_s,list_key)


  end

  private

  attr_reader :params
end


class Parse
	@@delimiter=[' % ',' $ '].freeze

	def find_delimiter(line)
		del=""
		headers=[]
		@@delimiter.each do|d|
			
			header = line.split(d)
			if header.length > 1
				del = d.strip
				headers = header 
			end
		end
		return del,headers
	end

	def parse(lines)
  		firstline=lines.split("\n")
		first = find_delimiter(firstline.first)
		return_array =[]

		for l in 1..(firstline.length - 1) do
			new_line = firstline[l].split(first[0])
			new_hash={}
			for m in 0..(first[1].length - 1) do
				new_hash[first[1][m]]= new_line[m].strip
			end
			return_array << new_hash
		end 
  	return return_array
  end
end


class Sort
	require 'date'
  def display(list,order,list_key)
  	result=[]
  	city_list = {'LA'=>'Los Angeles','NYC'=>'New York City'}
  	 list=list.sort_by { |k| k[order] }

  	 	list.each do |l|
  	 		new_a = []
  	 		list_key.each do |k|
  	 			if k=='city' && city_list.include?(l[k])
  	 				new_a.push(city_list[l[k]])
  	 			elsif k=='birthdate'
  	 				d= Date.parse(l[k])
  	 				new_a.push(d.strftime("%-m/%-d/%Y"))
  	 			else
  	 				new_a.push(l[k])
  	 			end
  	 		end
  	 		result.push(new_a.join(", "))
  	 	end
  	 	return result
  end
end
