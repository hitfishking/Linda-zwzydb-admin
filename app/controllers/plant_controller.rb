# encoding: utf-8
class PlantController < ApplicationController
	#skip_before_filter :verify_authenticity_token
	skip_filter :verify_authenticity_token, :recieve_hash
	require 'aliyun/oss'
	include Aliyun::OSS

	config = YAML.load_file('config/secrets.yml')
	#Connect to Aliyun::OSS
	Aliyun::OSS::Base.establish_connection!(
			:server => 'oss-cn-qingdao.aliyuncs.com',  #Default value is : oss.aliyuncs.com
			:access_key_id     => config["aliyun_oss_access_key_id"],
			:secret_access_key => config["aliyun_oss_secret_access_key"]
	)

	# Called by ajax, no standalone view.
	def recieve_hash
		#recvd_json = params[:q_data]
		#p recvd_json

	end

	def index
		#render :file => 'public/index.html' and return
	end


	# 双击tree上种节点，启动store的load操作...
	# 用作Zhong form的后台支撑store.
	def zhong_query
		p "====zhong_query====="
		p params

		if params[:leaf]  #client端已经判断：只有isLeaf()才触发load动作；故此判断可不用。
			record_found = Zhong.where(:_id => params[:id])[0]
			#补充添加以下字段：
			#种表中有zhong_id、shu_id，为objectId类型，不可变；故增加一个zhong_id、shu_id2字段，string类型；用于前台combobox；
			record_found['zhong_id'] = record_found.id.to_s
			record_found['shu_id2'] = record_found.shu.id.to_s
			record_found['shu_name'] = record_found.shu.name
			record_found['ke_id'] = record_found.shu.ke.id.to_s
			record_found['ke_name'] = record_found.shu.ke.name
			#查询Aliyun::OSS，返回该种的图片数目
			oss_store = Bucket.find('pic-store')
			record_found['pic_count'] = oss_store.objects(:max_keys => 300, :prefix => record_found['pics']).size - 1
			p "====pic count==="
			p record_found['pic_count']

			render :json => {:data => record_found }
		end

		#render :json => { :success => true,
		#		:message => "Error message goes here." ,
		#		:data => records_found }
	end

	def zhong_update
		p "====zhong_update====="
		p params
		if params['zhong_id'] == '111'    #不得已为之；copy/paste，store.sync()触发的是update，却不是create.
		  redirect_to :action => zhong_create and return
			#return
		end

		tmp_zhong = Zhong.where(:_id => params['zhong_id'])[0]
		if tmp_zhong.nil?
			render :json => {:success => false, :message => '[Server]: 没有找到待更新的种，其可能已被删除!请检查。'}
			return false
		end

		tmp_zhong.update_attributes!(populate_zhong_json())

		render :json => {:success => true, :message => '[Server]: 种信息更新成功！' }
	end

	def zhong_create
		p "====zhong_create====="
		p params

		tmp_shu = Shu.where(:_id => params['shu_id2'])[0]
		if tmp_shu.nil?
			p "不能找到id/name为：" + params['shu_id2'] + '/' + params['shu_name'] + '的属.'
			render :json => {:success => false, :message => '[Server]: 没有找到新种所在的属，其可能已被删除!请检查。'}
			return false
		end

		tmp_shu.zhongs.create!(populate_zhong_json())

		render :json => {:success => true, :message => '[Server]: 成功建立新种！'}
	end

	def zhong_delete
		p "====zhong_delete====="
		p params

		theZhongs = Zhong.where(:_id => params['zhong_id'])
		if theZhongs.count > 0  #不得已为之，copy/paste新建时，会自动调用一次delete,须排除这种情况;
		  	theZhongs[0].destroy
			  render :json => {:success => true, :message => '[Server]: 该种已成功删除!' }
				return
		end

		render  :json => {:success => false, :message => '[Server]: 成功(未知删除操作!)'}
	end

	#用params[]构造种json数据
	def populate_zhong_json
		json_zhong = {
				:shu_id => params['shu_id2'],
				#:_id => params['zhong_id'],  #从种instance出发update，故不必填写此字段.
				:cname => params['cname'],
				:ldname => params['ldname'],
				:aliases => params['aliases'].split('、'),
				:xingtai => params['xingtai'],
				:gongneng => params['gongneng'],
				:guanshang => params['guanshang'],
				:huaqi => params['huaqi'],
				:pics => params['pics'],
				:shengtai => {
						:genxi => params['shengtai.genxi'],
						:huminity => params['shengtai.huminity'],
						:light => params['shengtai.light'],
						:moisture => params['shengtai.moisture'],
						:nanyi => params['shengtai.nanyi'],
						:salt => params['shengtai.salt'],
						:shouming => params['shengtai.shouming'],
						:soil => params['shengtai.soil'],
						:sudu => params['shengtai.sudu'],
						:temperature => params['shengtai.temperature']
				},
				:engineering => {
						:ziran_quyu => params['engineering.ziran_quyu'],
						:yingyong_quyu => params['engineering.yingyong_quyu'].split('、'),
						:shibie_tezheng => params['engineering.shibie_tezheng'],
						:zhongzhi_midu => params['engineering.zhongzhi_midu'],
						:miaomu_guige => params['engineering.miaomu_guige'],
						:sheji_jianyi => params['engineering.shigong_yaodian'],
						:yanghu_yaodian => params['engineering.yanghu_yaodian'],
						:cankao_jiage => params['engineering.cankao_jiage']
				}
		}
	end

	#upload pics，by Form Submit
	def pics_upload
		p "===upload_pics======"
		p params

		unless request.get?
			unless params[:upfile].original_filename.empty?
				uploaded_io = params[:upfile]
				tmp_file = File.open(Rails.root.join('public', 'upfiles', uploaded_io.original_filename), 'wb+') do |file|
					file.write(uploaded_io.read)
				end
				if tmp_file.nil?
					render :json => {:success => false, :message => '[Server]: 上传文件发生错误，请检查！'}; return false
				end
				                                                                                         #正确上传文件后，立即将此文件上传到Aliyun::OSS Bucket的指定目录下.
				pic_path = params['picpath']
				if pic_path.nil? || pic_path == ""
					render :json => {:success => false, :message => '[Server]: 没有指定文件路径，请检查！'}; return false
				end
				tmp_file = File.open(Rails.root.join('public','upfiles',uploaded_io.original_filename))  #此时文件已经存在
				OSSObject.store(pic_path + uploaded_io.original_filename, tmp_file, 'pic-store')
				tmp_file.close

				render :json => {:success => true, :message => '[Server]: 文件上传成功!'}; return true
			end
		end

	end

	def pics_query
		p "===pics_query======"
		p params
		tmp_zhong = Zhong.where(:_id => params['id'])[0]
		if tmp_zhong.nil?
			p "不能找到id/name为：" + params['id'] + '/'+params['cname'] + '的种.'
			render :json => {:success => false, :message => '没有找到指定种，其可能已被删除!请检查。'}
			return false
		end
		if tmp_zhong.pics.nil? || tmp_zhong.pics == ""
			p "没有为种:"+params['cname']+"指定图片存储目录，无法显示种图片."
			render :json => {:success => false, :message => '没有设置种图片目录，无法显示种图片!请检查。'}
			return false
		end

		#查询Aliyun::OSS中，该种的图片数量
		oss_store = Bucket.find('pic-store')
		pics_count = oss_store.objects(:max_keys => 300, :prefix => tmp_zhong.pics ).size
		p "===tmp_zhong.pics==="; p tmp_zhong.pics
		p "===piccount==="; p pics_count

		tmp_pic_list = []
		pics_count.times do |i|
			tmp_j = {}
			                                                                                                   #形如：http://pic-store.oss-cn-qingdao.aliyuncs.com/草本/矮牵牛/3.jpg
			tmp_j['pic_path'] = "http://pic-store.oss-cn-qingdao.aliyuncs.com/#{tmp_zhong.pics}#{i + 1}.jpg"   #从1开始
			tmp_j['pic_name'] = "#{i + 1}.jpg"
			tmp_pic_list << tmp_j
		end
		render :json => { "data" => tmp_pic_list }

	end

	def pics_update
		p "===pics_update======"
		p params

	end

	def pics_delete
		p "===pics_delete======"
		p params

		if params['pic_name'].nil? || params['pic_name'] == ""
			render :json => {:success => false, :message => '[Server]: 缺少文件名，无法执行删除!请检查。'}
			return false
		end
		if params['picpath'].nil? || params['picpath'] == ""
			render :json => {:success => false, :message => '[Server]: 缺少文件路径，无法执行删除!请检查。'}
			return false
		end

		OSSObject.delete(params['picpath'] + params['pic_name'], 'pic-store')
		render :json => {:success => true, :message => '[Server]: 文件删除成功!'}

	end

	def send_ke
		p "====send_ke====="
		                                #records_found = Ke.all.entries
		p params

		records_found = []              #返回string类型_id
		for i in (0..Ke.all.count - 1)
			tmp_hash = {}
			tmp_hash["_id"] = Ke.all[i]._id.to_s
			tmp_hash["name"] = Ke.all[i].name
			records_found << tmp_hash
		end
		render :json => {:data => records_found }

	end

	def send_shu
		p "====send_shu====="
		#records_found = Shu.all.entries
		p params
		p "---p params['filter'][3]-------"
		                                #p params['filter'][3]

		records_found = []              #返回string类型_id
		for i in (0..Shu.all.count - 1)
			tmp_hash = {}
			tmp_hash["_id"] = Shu.all[i]._id.to_s
			tmp_hash["ke_id"] = Shu.all[i].ke_id.to_s
			tmp_hash["name"] = Shu.all[i].name
			records_found << tmp_hash
		end
		p records_found
		render :json => {:shus => records_found }


	end

	#科属Query
	def query_keshu
		p "========="
		p params

		case params[:ntype]
			when ""    #root节点的ntype为空
				tmp_arr_ke = []
				for i in 0..(Ke.all.count - 1)
					tmp_arr_ke <<
							{	:text => Ke.all[i].name,
							   :id => Ke.all[i]._id.to_s,
							   :leaf => false,
							   :expanded => false,
							   :ntype => '科',
							   :newnode => false
							}
				end
				render :json => tmp_arr_ke

			when "科"
				tmp_arr_shu = []
				for j in 0..(Ke.where(:_id => params[:id])[0].shus.count - 1)
					tmp_arr_shu <<
							{  :text => Ke.where(:_id => params[:id])[0].shus[j].name,
							   :id => Ke.where(:_id => params[:id])[0].shus[j]._id.to_s,
							   :leaf => false,
							   :expanded => false,
							   :ntype => '属',
							   :newnode => false
							}
				end
				render :json => tmp_arr_shu

			when "属"
				tmp_arr_zhong = []
				for k in 0..(Shu.where(:_id => params[:id])[0].zhongs.count - 1)
					tmp_arr_zhong <<
							{	 :text => Shu.where(:_id => params[:id])[0].zhongs[k].cname,
							    :id => Shu.where(:_id => params[:id])[0].zhongs[k]._id.to_s,
							    :leaf => true,
							    :expanded => true,
							    :ntype => '种',
							    :newnode => false
							}
				end
				render :json => tmp_arr_zhong

			else
				#render :json => {:success => true}
				render :json => {:text => 'abc',:id => 1, :leaf => true, :ntype => 'zhong', :newnode => false}
		end

	end
	#科属Update
	def update_keshu
		i_len = params["records"].length  ; p i_len
		render :json => {:success => true} if i_len <= 0

		for i in (0..i_len - 1)
			str_id = params["records"][i]["id"]
			str_text = params["records"][i]["text"]
			str_ntype = params["records"][i]["ntype"]
			p "-------update-------------"
			p params["records"][i]

			unless str_ntype.nil? || str_text.nil?   #ntype空为root节点；text为空的节点为本tree枝条上的未改动节点，忽略
				if str_ntype == "科"
					unless Ke.where("_id" => str_id )[0].nil?
						tmp_ke = Ke.where("_id" => str_id )[0]
						tmp_ke.update_attributes("name" => str_text)
						tmp_ke.save!
					end
				end
				if str_ntype == "属"
					unless Shu.where("_id" => str_id )[0].nil?
						tmp_shu = Shu.where("_id" => str_id )[0]
						tmp_shu.update_attributes("name" => str_text)
						tmp_shu.save!
					end
				end
			end
		end
		render :json => {:success => true}

	end
	#科属Delete
	#只传递过来待删除的根节点，直接实施级联删除即可。
	def delete_keshu
		i_len = params["records"].length
		render :json => {:success => true} if i_len <= 0

		for i in (0..i_len - 1)
			p "-------delete-------------"
			p i_len
			p params["records"][i]

			str_id = params["records"][i]["id"]
			str_ntype = params["records"][i]["ntype"]

			if str_ntype == "科"
				Ke.where(:_id => str_id)[0].delete
				render  :json => {:success => true}; return
			elsif str_ntype == "属"
				Shu.where(:_id => str_id)[0].delete
				render  :json => {:success => true}; return
			else
				render  :json => {:success => false}; return
			end

		end

	end
	#科属Create
	def create_keshu
		i_len = params["records"].length  ; p i_len
		render :json => {:success => true} if i_len <= 0

		last_ke = nil
		for i in (0..i_len - 1)
			str_text = params["records"][i]["text"]
			str_ntype = params["records"][i]["ntype"]
			b_newnode = params["records"][i]["newnode"]
			id_parent = params["records"][i]["parentId"]

			if str_ntype == "科" && id_parent == "root"       #情况1：新科(保存对象以备后续属之用)
				last_ke = Ke.create!(name: str_text)
			elsif str_ntype == "属" && id_parent.nil? && (not last_ke.nil?)    #情况2：紧随科后的属
				last_ke.shus.create!(name: str_text)
			elsif str_ntype == "属" && (not id_parent.nil?)   #情况3：旧有科下的新属
				old_ke = Ke.where(:_id => id_parent)[0]
				old_ke.shus.create!(name: str_text)
			end

			p "------create--------------"
			p params["records"][i]
		end
		render :json => {:success => true}

	end

end
