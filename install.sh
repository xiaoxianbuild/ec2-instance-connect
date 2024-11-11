#!/usr/bin/env bash
echo "check system..."
PASS_OS_CHECK=0
if [[ -f /etc/os-release ]]; then
    if grep -q "Debian GNU/Linux 12" /etc/os-release && [ "$(uname -m)" = "x86_64" ]; then
        echo "    detected Debian 12 amd64"
        PASS_OS_CHECK=1
    fi
fi
if [[ $PASS_OS_CHECK -eq 0 ]]; then
    echo "    unsupported system"
    exit 1
fi
unset PASS_OS_CHECK

# https://docs.aws.amazon.com/systems-manager/latest/userguide/agent-install-deb.html
echo "installing aws ssm..."
curl -o /tmp/amazon-ssm-agent.deb https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sudo dpkg -i /tmp/amazon-ssm-agent.deb
sudo systemctl status amazon-ssm-agent
sudo systemctl enable --now amazon-ssm-agent

echo "installing aws ec2-instance-connect..."
echo "not implemented now"
curl -o /tmp/ec2-instance-connect_1.1.nightly_all.deb https://github.com/xiaoxianbuild/ec2-instance-connect/releases/download/nightly/ec2-instance-connect_1.1.nightly_all.deb
sudo dpkg -i /tmp/ec2-instance-connect_1.1.nightly_all.deb