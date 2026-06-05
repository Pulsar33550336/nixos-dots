{ ... }:
{
  programs.ssh.extraConfig = ''
    Host server
      HostName fd7a:115c:a1e0::2101:f7b1
      Port 2222
  '';
}
