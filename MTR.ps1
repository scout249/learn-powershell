$a="https://opendata.mtr.com.hk/data/mtr_lines_fares.csv"
$b="c:\temp\test1.csv"

Invoke-WebRequest -Uri $a -OutFile $b
Import-Csv $b | ? {($_.SRC_Station_Name -eq "Central" -and $_.DEST_STATION_NAME -eq "Kowloon Bay")}  
#Import-Csv $b | select SRC_Station_Name -Unique | convertto-csv | clip


function Get-MTRfare {
    param (
        [ValidateSet("Central","Admiralty","Tsim Sha Tsui","Jordan","Yau Ma Tei","Mong Kok","Shek Kip Mei","Kowloon Tong","Lok Fu","Wong Tai Sin","Diamond Hill","Choi Hung","Kowloon Bay","Ngau Tau Kok","Kwun Tong","Prince Edward","Sham Shui Po","Cheung Sha Wan","Lai Chi Kok","Mei Foo","Lai King","Kwai Fong","Kwai Hing","Tai Wo Hau","Tsuen Wan","Sheung Wan","Wan Chai","Causeway Bay","Tin Hau","Fortress Hill","North Point","Quarry Bay","Tai Koo","Sai Wan Ho","Shau Kei Wan","Heng Fa Chuen","Chai Wan","Lam Tin","Hong Kong","Kowloon","Olympic","Tsing Yi","Tung Chung","Yau Tong","Tiu Keng Leng","Tseung Kwan O","Hang Hau","Po Lam","Nam Cheong","Sunny Bay","Disneyland Resort","LOHAS Park","Hung Hom","Mong Kok East","Tai Wai","Sha Tin","Fo Tan","Racecourse","University","Tai Po Market","Tai Wo","Fanling","Sheung Shui","Lo Wu","Lok Ma Chau","East Tsim Sha Tsui","Sai Ying Pun","HKU","Kennedy Town","Ho Man Tin","Whampoa","Ocean Park","Wong Chuk Hang","Lei Tung","South Horizons","Hin Keng","Kai Tak","Sung Wong Toi","To Kwa Wan","Exhibition Centre","Che Kung Temple","Sha Tin Wai","City One","Shek Mun","Tai Shui Hang","Heng On","Ma On Shan","Wu Kai Sha","Austin","Tsuen Wan West","Kam Sheung Road","Yuen Long","Long Ping","Tin Shui Wai","Siu Hong","Tuen Mun")]
        $src,
        [ValidateSet("Central","Admiralty","Tsim Sha Tsui","Jordan","Yau Ma Tei","Mong Kok","Shek Kip Mei","Kowloon Tong","Lok Fu","Wong Tai Sin","Diamond Hill","Choi Hung","Kowloon Bay","Ngau Tau Kok","Kwun Tong","Prince Edward","Sham Shui Po","Cheung Sha Wan","Lai Chi Kok","Mei Foo","Lai King","Kwai Fong","Kwai Hing","Tai Wo Hau","Tsuen Wan","Sheung Wan","Wan Chai","Causeway Bay","Tin Hau","Fortress Hill","North Point","Quarry Bay","Tai Koo","Sai Wan Ho","Shau Kei Wan","Heng Fa Chuen","Chai Wan","Lam Tin","Hong Kong","Kowloon","Olympic","Tsing Yi","Tung Chung","Yau Tong","Tiu Keng Leng","Tseung Kwan O","Hang Hau","Po Lam","Nam Cheong","Sunny Bay","Disneyland Resort","LOHAS Park","Hung Hom","Mong Kok East","Tai Wai","Sha Tin","Fo Tan","Racecourse","University","Tai Po Market","Tai Wo","Fanling","Sheung Shui","Lo Wu","Lok Ma Chau","East Tsim Sha Tsui","Sai Ying Pun","HKU","Kennedy Town","Ho Man Tin","Whampoa","Ocean Park","Wong Chuk Hang","Lei Tung","South Horizons","Hin Keng","Kai Tak","Sung Wong Toi","To Kwa Wan","Exhibition Centre","Che Kung Temple","Sha Tin Wai","City One","Shek Mun","Tai Shui Hang","Heng On","Ma On Shan","Wu Kai Sha","Austin","Tsuen Wan West","Kam Sheung Road","Yuen Long","Long Ping","Tin Shui Wai","Siu Hong","Tuen Mun")]
        $dst
    )
    Import-Csv $b | Where-Object {($_.SRC_Station_Name -eq $src -and $_.DEST_STATION_NAME -eq $dst)}    
}


