以下是一个关于如何使用 Invoke-RestMethod 从网上获取 JSON 数据的中文教程，使用你提供的示例。

# 使用 PowerShell 的 Invoke-RestMethod 获取 JSON 数据教程

## 1. 获取数据

首先，我们使用 `Invoke-RestMethod` 从网上获取 JSON 数据。以下是一个示例：

`$data | Format-Table` 是 PowerShell 中用于格式化和显示数据的一种方式。以下是对它的中文解释：
`$data | Format-Table` 命令将 `$data` 中的数据以表格形式显示出来。它会自动调整列宽，使数据更易于阅读和理解。

```powershell
$data_json = "https://raw.githubusercontent.com/Purukitto/pokemon-data.json/refs/heads/master/pokedex.json"
$data = Invoke-RestMethod -Uri $data_json
$data | Format-Table
```


```
 id name                                                                      
 -- ----                                                                      
  1 @{english=Bulbasaur; japanese=フシギダネ; chinese=妙蛙种子; french=Bulbizarre}     
  2 @{english=Ivysaur; japanese=フシギソウ; chinese=妙蛙草; french=Herbizarre}        
  3 @{english=Venusaur; japanese=フシギバナ; chinese=妙蛙花; french=Florizarre}
...
896 @{english=Glastrier; japanese=ブリザポス; chinese=雪暴马; french=Blizzeval}       
897 @{english=Spectrier; japanese=レイスポス; chinese=灵幽马; french=Spectreval}      
898 @{english=Calyrex; japanese=バドレックス; chinese=蕾冠王; french=Sylveroy} 
```

你可以指定要显示的列，或者让 PowerShell 自动选择适当的列。
```
$data | Format-Table -Property name, base
```



## 2. 过滤数据
接下来，我们可以根据特定条件过滤数据。例如，过滤出英文名字包含 "pika" 的宝可梦：

```powershell
$filtered_pokemon = $data | Where-Object { $_.name.english -match "pika" }
$filtered_pokemon
```

```
id          : 25
name        : @{english=Pikachu; japanese=ピカチュウ; chinese=皮卡丘; french=Pikachu}
type        : {Electric}
base        : @{HP=35; Attack=55; Defense=40; Sp. Attack=50; Sp. Defense=50; 
              Speed=90}
species     : Mouse Pokémon
description : While sleeping, it generates electricity in the sacs in its 
              cheeks. If it’s not getting enough sleep, it will be able to use 
              only weak electricity.
evolution   : @{prev=System.Object[]; next=System.Object[]}
profile     : @{height=0.4 m; weight=6 kg; egg=System.Object[]; 
              ability=System.Object[]; gender=50:50}
image       : @{sprite=https://raw.githubusercontent.com/Purukitto/pokemon-data
              .json/master/images/pokedex/sprites/025.png; thumbnail=https://ra
              w.githubusercontent.com/Purukitto/pokemon-data.json/master/images
              /pokedex/thumbnails/025.png; hires=https://raw.githubusercontent.
              com/Purukitto/pokemon-data.json/master/images/pokedex/hires/025.p
              ng}
```


3. 格式化数据
我们可以使用 Format-Table、Format-List 和 Out-GridView 来格式化和查看数据。

使用 Format-Table
$filtered_pokemon | Format-Table -Property name, base
使用 Format-List
$filtered_pokemon | Format-List -Property name, base
使用 Out-GridView
$filtered_pokemon | Out-GridView
4. 下载图片
我们可以下载过滤后的宝可梦的图片到本地目录。例如，下载高分辨率图片到 C:\temp\：

$destination_folder = "C:\temp"
if (-not (Test-Path -Path $destination_folder)) {
    New-Item -ItemType Directory -Path $destination_folder
}

foreach ($pokemon in $filtered_pokemon) {
    $image_url = $pokemon.image.hires
    $file_name = [System.IO.Path]::GetFileName($image_url)
    $destination_path = Join-Path -Path $destination_folder -ChildPath $file_name
    Invoke-WebRequest -Uri $image_url -OutFile $destination_path
}

Write-Output "Images downloaded to $destination_folder"
5. 使用 Out-GridView 和 PassThru 下载多张图片
我们可以使用 Out-GridView 的 -PassThru 参数来选择并下载多张图片：

$selected_pokemon = $filtered_pokemon | Out-GridView -PassThru

foreach ($pokemon in $selected_pokemon) {
    $image_url = $pokemon.image.hires
    $file_name = [System.IO.Path]::GetFileName($image_url)
    $destination_path = Join-Path -Path $destination_folder -ChildPath $file_name
    Invoke-WebRequest -Uri $image_url -OutFile $destination_path
}

Write-Output "Selected images downloaded to $destination_folder"
通过以上步骤，你可以使用 PowerShell 从网上获取 JSON 数据，过滤数据，格式化数据，并下载图片。希望这个教程对你有帮助！
