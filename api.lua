local kong = kong
local fmt = string.format
local endpoints   = require "kong.api.endpoints"
return{
  ["/batch-plugins"] = {
    schema = kong.db.plugins.schema,
    POST = function(self, db, helpers)
      local consumer = {}
      if not self.params.consumers then
        kong.log.err("缺少批量消费者字段")
        return kong.response.exit(403, { message = "缺少批量消费者字段，请添加！" })
      end
      local consumers = self.params.consumers
      self.params.consumers = nil
      -- 遍历
      for k, v in pairs(consumers) do
        consumer.id = v
        self.params.consumer = consumer
        local entity, error = db.plugins:insert(self.params)
        if error then
          kong.log.err(fmt("批量添加消费者过程当中第%i个消费者出错！", k), error)
          return kong.response.exit(404, { message = fmt("批量添加消费者过程当中第%i个消费者出错！ 错误为：%s", k, error) })
        end
      end
      return kong.response.exit(202, { message = "插件全部安装成功！" })
    end
  },
  ["/batch-groups/acls/:acls"] = {
    schema = kong.db.acls.schema,
    POST = function(self, db, helpers)
      self.args.post.group = self.params.acls
      local consumer = {}
      if not self.params.consumers then
        kong.log.err("缺少批量消费者字段")
        return kong.response.exit(404, { message = "缺少批量消费者字段，请添加！" })
      end
      local consumers = self.params.consumers
      self.args.post.consumers = nil
      -- 遍历
      for k, v in pairs(consumers) do
        consumer.id = v
        self.args.post.consumer = consumer
        local acls, _, err_t = endpoints.insert_entity(self, db, db.acls.schema)
        if err_t then
          kong.log.err(fmt("将消费者批量添加到组的过程当中出错，位置为第%i个消费者！错误为：%s", k, err_t))
          return kong.response.exit(404, { message = fmt("将消费者批量添加到组的过程当中出错，位置为第%i个消费者！错误为：%s", k, err_t) })
        end
      end
      return kong.response.exit(202, { message = fmt("已成功将指定消费者全部添加到%s中！",self.params.acls) })
    end

  }
}
