# Batch-Plugins——批量插入插件向量

## 1. 插件结构

- api.lua

- handle.lua
- schema.lua

## 2. 插件安装

- `POST 		/plugins`

  - 请求体

    ```json
    {
    	"name":"batch-plugins"
    }
    ```

  - 返回体示例

    ```json
    {
        "created_at": 1583454376,
        "config": {
            "name": "batch-plugins"
        },
        "id": "72597488-8ed2-407e-b425-9dd64c6407be",
        "service": null,
        "enabled": true,
        "protocols": [
            "grpc",
            "grpcs",
            "http",
            "https"
        ],
        "name": "batch-plugins",
        "consumer": null,
        "route": null,
        "tags": null
    }
    ```

- `DELETE        /plugins/{plugin id}`

## 3.使用插件

### 3.1 批量插入插件

> 批量插入插件的方法和插入单个插件方法类似，需要对`请求路径`和请求体中的`consumer`做修改
>
> - 只需将原来的consumer改成consumers的数组即可，其他和原来的插件使用方式相同

- `post			/batch-plugins`

- 请求体

  此处以Request-Termination插件的批量插入为例

  ```json
  {
  	"name":"request-termination",
  	"service":{
  		"id":"cd33386a-271e-4361-aeca-ab6d1c37817d"
  	},
  	"consumers":["da473c5c-6acb-42a4-aaa3-653abd3a340d","a041f80e-e7f4-46cc-9c8d-fe524a02f3eb","777cbe68-9c80-4df8-badc-03e6b8274681","cf65de70-884f-42e7-87aa-a093d67b8c86"],
  	"config":{
  		"status_code":403,
  		 "message":"So long and thanks for all the fish!"
  	}
  }
  ```

- 返回体

  - 请求成功返回示例

    ```json
    Status:202 Accepted
    {
        "message": "插件全部安装成功！"
    }
    ```

  - 请求失败返回示例

    ```json
    Status:404 Not Found
    {
        "message": "批量添加消费者过程当中第1个消费者出错！ 错误为：[postgres] UNIQUE violation detected on '{consumer={id=\"da473c5c-6acb-42a4-aaa3-653abd3a340d\"},name=\"request-termination\",route=null,service={id=\"cd33386a-271e-4361-aeca-ab6d1c37817d\"}}'"
    }
    ```

    

### 3.2 批量将消费者归入组（acls）

- `POST          /batch-groups/acls/{组名称}`

- 请求体

  > 只需要consumers字段，array类型即可

  ```json
  {
  	"consumers":["da473c5c-6acb-42a4-aaa3-653abd3a340d","a041f80e-e7f4-46cc-9c8d-fe524a02f3eb"]
  }
  ```

- 返回体

  > 返回体和3.1节当中的类似

