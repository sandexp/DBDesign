#### date �ֶε����

##### date�ֶεĴ洢�ṹ

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


##### date�ֶε����л�/�����л�
�����ַ��������л��ͷ����л�

##### date�ֶεıȽ��߼�
�ַ����Ƚ��߼�

##### date�ֶε�У��
��ݲ�����ǰ���� ����Ҫ����λ
�·ݲ���ʡȥǰ����, ת����Χ��1-12֮��
���ڲ���ʡȥǰ����,ת������ֵ��Ҫ�����·ݺ���ݹ�ͬ����

�̳�TupleValue��,ʵ��toString�Լ�compare����
�ڹ��캯���ڲ���������У��


##### ֧��date�ֶε�����