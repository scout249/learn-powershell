# 存取控制清單 (Access Control List, ACL)
存取控制清單 (ACL) 也是一種權限控管的機制，是作業系統用來管控資源的使用權限檔案，如：資料夾、印表機、註冊機碼等。 它是由存取控制項 (ACE) 所組成，每一項 ACE 指明了某物件是否可被存取。 例如，若想阻止系統管理員以外的任何人讀取某個檔案，就可以建立一個特定的 ACE，並套用到該檔案的存取控制清單 (ACL) 即可。

ACL 包含二種類型：

- discretionary access control list (DACL)：自主式存取控制清單
- system access control list (SACL)：系統存取控制清單

# 自主式存取控制清單 ( Discretionary Access Control List, DACL )

## 什麼是自主式存取控制清單（Discretionary Access Control List, DACL）
自主式存取控制 (DAC) 是一種針對使用者或群組，允許或拒絕他們存取資源的一種機制。 它使用存取控制項 (ACE) 來判斷使用者或群組的存取權限。 例如，若想阻止系統管理員以外的任何人讀取某個檔案，就可以建立一個特定的 ACE，並套用到該檔案的存取控制清單 (ACL) 即可。

在 Windows 作業系統裡，每一個系統物件都擁有自己的 ACL 權限表， 以 NTFS 檔案系統內的檔案來說好了，每個檔案都有六種基本權限：Full Control、Modify、Read＆Execute、Read、Write、特殊權限。 而在 [進階] 選項中，還能更進一步的設定檔案的所有權限，包含檔案的 7 種延伸權限，故檔案的權限設定總共有 13 種，(檔案擁有的延伸權限有 7 種，故檔案的權限設定共有 13 種，資料夾則是 15 種左右) 如下圖：

![](https://lh3.googleusercontent.com/-zy3JY3lg_kA/VVVfKn6Z6sI/AAAAAAAAO5E/vVK1JtuLSnA/s850/file_security.png)

## DACL 的管控機制

若將使用者看成主體(subject)，檔案或資源看成客體(object)。機制就是將權限管制表記錄在主體身上，而 DACL 則是將權限管制表記錄在客體身上。

這個管制表就稱為存取控制清單 (ACL)，而清單內則是由存取控制項 (ACE) 所組成，每一項 ACE 指明了某物件是否可被存取(如圖)。 當 Process 想要存取一個受保護的物件，系統會先檢查該物件的 DACL 中的 ACEs 項目，以決定是否授與 Process 的存取權限。 若該物件沒有 DACL，系統就會授與任何人完整的存取權限。 若該物件有 DACL，卻不含任何 ACEs，系統則會禁止任何人的存取。

如 Alice 和 Bob 擁有資料庫之存取權限，在資料庫維護存取控管清單上，Alice 僅有讀取權限，Bob 則擁有讀取、寫入、修改與刪除權限。

![](https://lh3.googleusercontent.com/-JLD_A28VACI/VVVfLtf1BjI/AAAAAAAAO5I/gTuOQq-wS8U/s493/acl.png)

## ## 系統如何計算有效的使用權限
### 明確的與繼承的使用權限

在指派使用權限給物件時，有二種方法

-   **明確指派：(Explicit Permissions)**  
    當指派 DACL 給一個物件時，就是在建立一個明確的使用限權。例如，指派明確的使用權限給每個檔案、資料夾、登錄機碼。
-   **繼承指派：(Inherited Permissions)**  
    繼承的使用權限比明確指派有效率多了。它使用尤其父層物件傳播下來的權限。 有了這樣子的機制，在建立新物件時，就不需要明確指定使用權限。新的物件會繼承其父層的使用權限。

### 使用權限是累積的 (Lab1)

授與一個使用者或所屬群組的使用權限是用累積(cumulative)的概念的。 例如，使用者 Hong，同時為 Sales 和 IT 群組的成員， 若某一個檔案的 ACL 給 Hong 只有 Read 權限，給 IT 群組 Modify 權限，給 Sales 群組 Full Control 權限。 如此一來，Hong 將有 Full Control 權限。

### 拒絕權限永遠覆寫授與權限 (Lab2)

在多個 ACL 中，若有一個是拒絕存取用的 ACL，那麼它將覆寫授與存取權限的 ACL。 如上例中，若  Hong 被拒絕存取，即使 Hong 為 Sales 群組的成員，且該群組有 Read 權限，Hong 也無法存取該檔案。


# 系統存取控制清單 ( System Access Control List, SACL )

系統存取控制清單 (SACL)，有時也稱為稽核 ACE，它讓系統管理員可以記錄誰嘗試存取安全性物件。 SACL 與 DACL 類似，它們都是使用 ACE 來定義特定資源的存取規則。 但是與 DACL 不同的是，它不會限制資源的存取，而是當使用者嘗試存取資源時，會產生事件記錄，並記載到 Windows 事件記錄中的安全性類別。

不過，預設上，即使指派了 SACL 給資源，Windows 也是不會記錄稽核事件的。它必須還得啟動物件的存取稽核原則才行。該項設定位於本機安全性原則管理工具裡頭。

---

```
# 設置用戶名變數
$username1 = "Mono"
$username2 = "Hong"
$group1 = "IT"
$group2 = "Sales"

$password = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force

# 創建用戶帳戶
New-LocalUser -Name $username1 -Password $password -FullName $username1
New-LocalUser -Name $username2 -Password $password -FullName $username2

# 創建用戶組
New-LocalGroup -Name $group1
New-LocalGroup -Name $group2

Add-LocalGroupMember -Group $group1 -Member $username1
Add-LocalGroupMember -Group $group2 -Member $username1,$username2
```

```
# 創建空文件夾
New-Item -ItemType Directory -Path 'C:\Share'
New-Item -ItemType Directory -Path 'C:\Share\Assets'
New-Item -ItemType File -Path 'C:\Share\Client_list.txt'
New-Item -ItemType File -Path 'C:\Share\Client_projects.txt'

# 為共享文件夾路徑分配一個變數。 創建變數減少了鍵入並使路徑更易於重用。
$dir = 'C:\Share'
```

使用 PowerShell 查看 NTFS 權限
PowerShell 允許您使用 `Get-Acl` cmdlet 快速查看 NTFS 權限。 在以下部分中，您將了解如何使用 cmdlet 查看文件或文件夾的 NTFS 權限。

存取控制清單（ACL 是存取控制條目 (ACE) 的清單。ACL 中的每個 ACE 標識一個受託者並指定允許、拒絕或審計的訪問權限。安全對象的安全描述符可以包含兩種類型的 ACL : 一個 DACL 和一個 SACL。

傳統上，您可以通過右鍵單擊 C:\Share 文件夾，單擊**屬性**，選擇**NTFS 安全選項**，然後單擊**進階**按鈕來查看 ACL。 您可以在下面看到 GUI 如何顯示權限的示例。
![Access Control List using Advanced Security Settings for Share](https://adamtheautomator.com/wp-content/uploads/2020/09/Untitled-98-1.png)

上面的例子有一些權限條目和屬性編號。 仔細檢查它們，因為您將在本節後面看到比較。

使用您之前創建的目錄，使用 `Get-Acl` 顯示該目錄的當前 NTFS 權限。

```
Get-Acl  -Path $dir
```
您現在應該在以下屏幕截圖中看到路徑、所有者和訪問級別詳細信息。
![Access Control List](https://adamtheautomator.com/wp-content/uploads/2020/09/Untitled-99-1.png)

上面屏幕截圖中顯示的 `Access` 屬性包含有關 ACL 的附加信息，但它會滾動到屏幕外，如上面 FullControl 末尾的三個點所示。 有一種更好的方法來查看此屬性，方法是將前面的命令括在圓括號或圓括號中以查看 `Access` 對象屬性。 僅通過運行以下代碼來查找此對象的 `Access` 屬性。

```
(Get-Acl  -Path $dir).Access
```

如以下屏幕截圖所示，輸出被包裝以使命令更容易查看各個 `Access` 屬性：
![Access Control Entities](https://adamtheautomator.com/wp-content/uploads/2020/09/Untitled-100-1.png)

如果您有許多訪問控制實體 (ACE)，以上述方式查看訪問屬性可以使終端輸出快速向下滾動屏幕。 每個實體都包含 FileSystemRights、AccessControlType、IdentityReference、IsInherited、InheritenceFlags 和 PropagationFlags 屬性。 為了使這一切更具可讀性，請將對象通過管道傳輸到 `Format-Table -AutoSize`。 運行以下命令。

```
(Get-Acl -Path $dir).Access | Format-Table -AutoSize
```

正如您在下面的屏幕截圖中看到的，使用 `Format-Table -AutoSize` 時訪問屬性更清晰、更有條理：
![Cleaner output when piping to Format-Table](https://adamtheautomator.com/wp-content/uploads/2020/09/Untitled-2020-09-08T180844.035-1-1024x144.png)

檢查屬性和列號。 請注意，這些屬性與您在教程開始時在 GUI 中看到的屬性相同。
![Access Control List using Advanced Security Settings for Share](https://adamtheautomator.com/wp-content/uploads/2020/09/Untitled-2020-09-08T180939.655.png)



## Lab 1 使用權限是累積的
```
$acl = Get-Acl $dir
# 給 Hong 只有 Read 權限
$AccessRule1 = New-Object System.Security.AccessControl.FileSystemAccessRule("Hong","Read","Allow")

# 給 IT 群組 Modify 權限
$AccessRule2 = New-Object System.Security.AccessControl.FileSystemAccessRule("IT","Modify","Allow")

# 給 Sales 群組 Full Control 權限
$AccessRule3 = New-Object System.Security.AccessControl.FileSystemAccessRule("Sales","FullControl","Allow")

$acl.SetAccessRule($AccessRule1)
$acl.SetAccessRule($AccessRule2)
$acl.SetAccessRule($AccessRule3)

$acl | Set-Acl $dir

# 如此一來，Hong 將有 Full Control 權限
Install-Module -Name NTFSSecurity

Get-NTFSEffectiveAccess $dir -Account Hong
```

Output
```
Account              Access Rights Applies to     Type  IsInherited InheritedFrom
-------              ------------- ----------     ----  ----------- -------------
HK-C00000000361\Hong FullControl   ThisFolderOnly Allow False                    

```


## Lab 2 拒絕權限永遠覆寫授與權限
```
$acl = Get-Acl $dir\Client_list.txt


# 給 Hong Read Deny權限
$AccessRule1 = New-Object System.Security.AccessControl.FileSystemAccessRule("Hong","Read","Deny")

# Sales 群組的成員，且該群組有 Read 權限
$AccessRule2 = New-Object System.Security.AccessControl.FileSystemAccessRule("Sales","Read","Allow")


$acl.SetAccessRule($AccessRule1)
$acl.SetAccessRule($AccessRule2)

$acl | Set-Acl $dir\Client_list.txt

# 若有一個是拒絕存取用的 ACL，那麼它將覆寫授與存取權限的 ACL。 
# 如上例中，若 Hong 的被拒絕存取，Hong 也無法存取該檔案。
Get-NTFSEffectiveAccess $dir\Client_list.txt -Account Hong
```


如您所見，使用拒絕權限完成的大部分結果都可以使用允許權限輕鬆實現。 因此，大多數管理員嘗試避免使用拒絕權限，儘管有時這是不可避免的。

總之，如果您必須使用拒絕權限，請確保遵循以下權限優先級層次結構。
請注意，該列表從具有最高優先級的權限開始到具有最低優先級的權限。

- 明確拒絕 (Explicit Deny)
- 明確允許 (Explicit Allow)
- 繼承拒絕 (Inherent Deny)
- 繼承允許 (Inherent Allow)

