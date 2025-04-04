let
  keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzdDikp/VUciRmRRP1Ww0fuvtqVO+KKVLJJU3iKext91eDITB0wPIeLa3PxXbgBbXWnlCQYs+2+LSnxfSiOLCYdsBmE9Ui1H9KQ6lUsc8imnSAdj5NThpFCfSuItD8N8ix+vYrDwbj8G4K9kBInmQpwxWjZYBrgC8TDRjimY2jkKzata4Ab6pWFnv/kRRb8odLSv34hij4/Xe33PVSgUNAo8zCTskmJnRNC9f31Rn0FIRU+QjJK8paCGJ16PbQK9QbDdYHY1odSbvPQEyLJPPj96TSx2Ge806BQWOR2FmwKqUKfHD3xO4zS/kS3v8YQ4oDQUwhI2MK2YV2GApyGLDSoKsCFrI8kt8n8icScxWWYCyUvf8VZi8vzjuUeyHeB35+mpjSyNv1NVU5vj0C3PU69zAjzol7Za5Ju1oyciE8DiWKN7KSvegXBvNpgMwGhLj0ePcUHYIbu77UhpUwJUeewqFAv/oswkOMMMSO3a28rnEgMrwj/YHCcF+e25prn5s="
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjCFwgISKI8AhomYqDYf0ISMX47F2TEvC/y759jdNnrgvOtaYHDNULD0efD8HSl835sF1dfoWoaHqXVBq7HaBkqWUiwA4VB7wSBSnZOLRaMz+QNWH/EBNl7w0WBOtt2keuMXZa/qkHIztNZHFnYZbUyz5NjtE+aIEDc+vMMxBmG+1IF1EVMlWbr0sn0fWnrsbPMbS5yfsiwumzdrJxA2N4A0pm0ap4j4T0phqeEMbFfRa1HIqF36EZgwhl0iw3l9h26YijkV1C4L9fbSzYJOXUmu/f2pl4TvLR25f5sZZgeyZiRl/1ZxzLKPNHGz7V85kggyQ1CHlsP8k7EEbKMD71Io1x15inV90ZJt62uREYi+n+mPhyxYsIR1uQnzrSbykP09LCzqMMjzOnpaQ8uHOLOMsZDV47SkIjlynVkq0XYu8CeHfGTFvGqmYI1nChvoumHCRaPKZcVI0gDEcqaRSP1AtZIt8fgZQKgJLoHMDW8geoq2SHC7lx72YZRFD+VqE="
  ];
  workkeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC12Ig0vdqUScUdFNy8RKFn2NNOrM9O/TCvQ6RSbHm0q9iGziZbjYe83BBJ8rcfTYVRnW8/kCV106w570jKsQyt0OWvgqtSjfnhp/RuB6VVIsuZKJiJR7yvsNnM99BrCnMJDCTUq1MeWMdi6X1B48vS+JJPexutn8VxVsxN/cICi9hDYTXk4zp/7yAuE/NTVqnizSTRdyFAP1t1dJndVQfy8pbTTSZDl88qODixNY1s3w42ZpYwphaY31sl9tvcwL/Adbnr4N+NO5OIfUBu8COYCWayqGi0hKLE9EoeMepMqDq732EFn7n1vXGpXxfORLhJr4qAFQZueAztdeBbQGS24nUt4JRt9iI8M/VkI7e3yr6EpdMN1b3/cMSiwafVWIJemcOJoBnFWn1RgQPEHGesoezDdKRmM8SQXsos2hbILzeBuPRVLhx4qZhFIal3kPu+DOZzvHL7wl5YA5455AQTQNgAIX0u7uA/ZjB+b7nsZMTX4FbIzmEjiVmC5FWJpnk="
  ];
in
{
  "backgrounder-config.age".publicKeys = keys;
  "yukari.age".publicKeys = keys;
  "patchouli.age".publicKeys = workkeys ++ keys;
}
