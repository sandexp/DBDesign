#### ��ֵ���͵Ĵ洢

���ڿ��ܴ��ڿ�ֵ�ı�ռ�,��Ҫ���һ����ֵ��¼�������¼��ʹ��bitmap���д洢�����ڱ�ʾ��ֵ�洢��λ�ã��Ӷ�ָ�������ݵ����л��ͷ����л�

��bitmap��nλΪ1��ʱ��,��ʾ��n���ֶ����л�ʱ��洢�˿�ֵ,���з����л���ʱ���ȡ����ֶε�ʱ����������.

ͬʱ�����ݽ���д���ʱ����Ҫ���bitmap�Լ���ռ��nullable�Ķ������sql���﷨��飬�����鵽ĳ���ֶβ���Ϊnull,���ǲ������ֵΪnull��ʱ��
��Ҫ��ʾ������Ϣ. ͬʱ����null���͵ıȽ�Ҳ��Ҫ����ʵ��,���ؽ������false(С��)

���Կ��Ը���null���͵ĽṹΪ
```c++
class NullData{

	public:
		int compareTo(AbstractData data){
			return -1;
		}
}
```

��Ҫ��Record/Row��ά��һ��bitmap���schema��ṹ������

��Ҫʵ��
```c++
	// ��������ʱ����֤
	bool validate(Schema* schema,BitMap* bitmap){
	
	}

	bool serialize(Record* record){
	
	}

	Record deserialize(File* file,long pos){
	
	}
```

