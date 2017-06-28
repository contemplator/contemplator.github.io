// 引入執行 command line 指令的套件
var cp = require('child_process');

// 取得 file 參數
// 執行 npm run new --file=[filename]
let filename = process.env.npm_config_file;

// 使用 hexo 新建文章
let cmd_new = "hexo new ";
cmd_new += "\"" + filename + "\"";

// 執行 hexo new 指定
let new_process = cp.exec(cmd_new, (error, stdout, stderr) => {
    if (error) {
        console.error(`exec error: ${error}`);
        return;
    }
    
    let cmd = "code ./source/_posts/";
    filename = filename.replace(/\s/g, "-");
    cmd += filename + '.md';

    // 執行使用 vs code 打開文章的指令
    cp.exec(cmd, function (error, stdout, stderr) {
        if (error) console.log(`exec error: ${error}`);
    });
});