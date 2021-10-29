
#### 元数据检查

功能： 检查sql语句中是否包含不正确的列名表名信息 如果存在则返回失败 

实现思路：在一个简单查询的范围内(简单查询指的是 不包含子查询的查询), 含有这些内容的包括 投影，谓词，同时也要校验group by，
order by having中的字段信息.

获取这些信息之后，需要查询元数据表，检测是否存在有这个字段/表信息

1. 对元数据表的查询

假定通过lex/yacc 解析出来的字段为 x.y(没有数据库的逻辑划分最多只有这么长)

首先需要进行格式校验, 去除前后多余的空格信息，拆解出tableName=x, fieldName=y. 使用元数据`table_meta_cpp`中的` FieldMeta * TableMeta::field(const char *name)`
进行查找，如果返回值为NULL，则表示无此元数据信息, 抛出异常. 这条是对于属性而言的.


2. 解析处理字段为索引的情况

例如一条创建索引的语句,就会遇到索引字段, 查询索引需要在索引元数据index_meta中检索

3. 关于表元数据的检测

在数据库文件db.h 中含有一个对表元素进行校验的函数 `Table *find_table(const char *table_name)` 用于检测表的正确性

4. 属性元数据校验

当在表层级查询到含有同名的属性之后，就需要比较属性一些参数是否相等了

minidb对属性的描述有下：
```c++
  std::string  name_;
  AttrType     attr_type_;
  int          attr_offset_;
  int          attr_len_;
  bool         visible_;
```

其中,我们需要对参数类型进行校验，以及可见性进行校验，如果一个属性被隐藏是不能被访问的.