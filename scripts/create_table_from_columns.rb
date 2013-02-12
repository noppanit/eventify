require 'rubygems'
require 'pp'

columns = "event_id,user_id,start_time,city,state,zip,country,lat,lng,c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_10,c_11,c_12,c_13,c_14,c_15,c_16,c_17,c_18,c_19,c_20,c_21,c_22,c_23,c_24,c_25,c_26,c_27,c_28,c_29,c_30,c_31,c_32,c_33,c_34,c_35,c_36,c_37,c_38,c_39,c_40,c_41,c_42,c_43,c_44,c_45,c_46,c_47,c_48,c_49,c_50,c_51,c_52,c_53,c_54,c_55,c_56,c_57,c_58,c_59,c_60,c_61,c_62,c_63,c_64,c_65,c_66,c_67,c_68,c_69,c_70,c_71,c_72,c_73,c_74,c_75,c_76,c_77,c_78,c_79,c_80,c_81,c_82,c_83,c_84,c_85,c_86,c_87,c_88,c_89,c_90,c_91,c_92,c_93,c_94,c_95,c_96,c_97,c_98,c_99,c_100,c_other"

sql = "CREATE TABLE eventify.events ("
sql << "id int NOT NULL AUTO_INCREMENT,"
columns.split(",").each do |column|
	sql << "#{column} VARCHAR(255), \n"
end 

sql << " PRIMARY KEY ('id'));"

puts sql



