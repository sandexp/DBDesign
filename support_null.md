#### 空值类型的存储

对于可能存在空值的表空间,需要设计一个空值记录表，这个记录表使用bitmap进行存储，用于表示空值存储的位置，从而指导表数据的序列化和反序列化

当bitmap第n位为1的时候,表示第n个字段序列化时候存储了空值,进行反序列化的时候读取这个字段的时候跳过即可.

同时对数据进行写入的时候，需要结合bitmap以及表空间对nullable的定义进行sql的语法检查，如果检查到某个字段不可为null,但是插入的数值为null的时候，
需要提示报错信息. 同时对于null类型的比较也需要进行实现,返回结果都是false(小于)

所以可以概括null类型的结构为
```c++
class NullData{

	public:
		int compareTo(AbstractData data){
			return -1;
		}
}
```

需要在Record/Row中维护一个bitmap表和schema表结构描述符

需要实现
```c++
	// 插入数据时候验证
	bool validate(Schema* schema,BitMap* bitmap){
	
	}

	bool serialize(Record* record){
	
	}

	Record deserialize(File* file,long pos){
	
	}
```

