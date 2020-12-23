{
  users = {
    users = {
      massi = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        subUidRanges = [{ startUid = 100000; count = 65536; }];
        subGidRanges = [{ startGid = 100000; count = 65536; }];
      };
    };
  };
}
