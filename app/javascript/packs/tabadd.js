  layui.use("element", function () {
    var element = layui.element,
      $ = layui.jquery;
    var active = {
      tabAdd: function (url, id, title) {
        window.parent.layui.element.tabAdd("demo", {
          title: title,
          content: '<iframe data- frameid=”' + id + '" scrolling="auto" frameborder="0" src="' + url + '"style= "width: 100%; height:1000px"></iframe>',
          id: id
        })
      },
      tabchange: function (id) {
        window.parent.layui.element.tabChange("demo", id)
      }
      
    };
    $(".linkActive").on("click", function () {  
      // console.log('test22222');
      var datas = $(this);  
      if (datas[0].dataset.url == "") {
        return;
      } 
      tabcz(datas, active);
    });
  });


  

  function tabcz(datas, active) {
    var sum = 1;
    if ($(" .layui-tab-title li[lay-id]", window.parent.document).length <= 0) {
      active.tabAdd(datas.attr("data-url"), datas.attr("data-id"), datas.attr("data-title"));
    } else {
      var isOpen = false;
      $.each($(".layui-tab-title li[lay-id]", window.parent.document), function () {
        if ($(this).attr("lay-id").indexOf(datas.attr("data-id")) >= 0) {
          isOpen = true;
          sum++;
        }
      });
      active.tabAdd(datas.attr("data-url"), datas.attr("data-id") + sum, datas.attr("data-title"))
    }
    active.tabchange(datas.attr("data-id") + sum);
  }