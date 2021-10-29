#### date 字段的添加

##### date字段的存储结构

```c++
	class DataType{
		private:
			string value;

		public:
			bool validate();

			int compare();

			void serialize(file* f,int offset);

			void deserialize(string &ptr, int size);

			long long timeStamp();
	}
```


##### date字段的序列化/反序列化
调用字符串的序列化和反序列化

##### date字段的比较逻辑
字符串比较逻辑

##### date字段的校验
年份不存在前导零 必须要有四位
月份不能省去前导零, 转换后范围在1-12之间
日期不能省去前导零,转换后数值需要根据月份和年份共同决定

继承TupleValue类,实现toString以及compare函数
在构造函数内部进行类型校验


##### 支持date字段的索引