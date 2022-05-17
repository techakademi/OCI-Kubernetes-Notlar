#!/bin/bash

# Bu skript ile, Ubuntu işletim sistemine yeni Kubernetes'in son sürümün yükleme işlemini gerçekleştirebilirsiniz.
echo
echo -------------------------------------------------------------------------------------
echo "Merhaba, Ben Ubuntu Sunucusuna Kubernetes'i kuracak olan Droid'inim."
echo -------------------------------------------------------------------------------------
sleep 2
echo
# Sunucu Version kontrol & görüntüleme
echo
echo -------------------------------------------------------------------------------------
echo "Sunucu Sürüm Kontrolünü yapıyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
lsb_release -a
sleep 1

# Güncelleme İndex'ini güncelleme adımı
echo
echo -------------------------------------------------------------------------------------
echo "Güncelleme Index'ini Güncelliyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo apt update -y
sleep 1

# Güncellenecek paketlerin uygulanması
echo
echo -------------------------------------------------------------------------------------
echo "Güncel Paketleri Yükleme işlemine başlıyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo apt upgrade -y
sleep 1

# Kubernetes kurulumu için ihtiyaç duyulan ek paketlerin kurulumu
echo
echo -------------------------------------------------------------------------------------
echo "Kubernetes Kurulumu ek paketleri yüklüyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo apt-get install -y apt-transport-https ca-certificates curl
sleep 1

# Kubernetes'in resmi GPG anahtarını yükleyelim
echo
echo -------------------------------------------------------------------------------------
echo "Kubernetes'in resmi GPG anahtarini yüklüyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
sleep 1

# Kubernetes'in Kararlı deposunu kurmak için aşağıdaki komutu kullanın.
echo
echo -------------------------------------------------------------------------------------
echo "Kubernetes'in deposunu kuruyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sleep 1

# Kubernetes kurulumuna başlayalım.
echo
echo -------------------------------------------------------------------------------------
echo "Güncelleme yapıyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo apt update
sleep 1

# Kubernetes kubeadm, kubelet, kubectl ve Containerd paketlerini yükleyelim.
echo
echo -------------------------------------------------------------------------------------
echo "Kubernetes kubeadm, kubelet, kubectl ve Containerd paketlerini yüklüyorum."
echo -------------------------------------------------------------------------------------
sudo apt install  kubelet kubeadm kubectl containerd -y
sleep 2

# Kubernetes & Containerd update hol komutunu çalıştır.
echo
echo -------------------------------------------------------------------------------------
echo "Kubernetes & Containerd apt-update donduruyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo apt-mark hold kubelet kubeadm kubectl containerd
sleep 1

# Cluster'ın overlay trafiği oluşturabilmesi, IP tables'in bridge trafiğini görebilmesi için kernel modüllerini etkin hale getiriyoruz.
echo
echo -------------------------------------------------------------------------------------
echo "Overlay trafiği için IP tables etkinleştiriyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
sleep 1
sudo modprobe overlay
sleep 1
sudo modprobe br_netfilter

# Sistemlerin reboot edildiklerinde, mevcut parametreleri korumaları için ayarları set ediyoruz.
echo
echo -------------------------------------------------------------------------------------
echo "Sistemlerin reboot edildiklerinde, mevcut parametreleri korumaları için ayarları set ediyoruz."
echo -------------------------------------------------------------------------------------
sleep 2
echo
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
sleep 1

# Sunucuları yeniden başlatmadan sistem parametrelerini uygulamaya alıyoruz.
echo
echo -------------------------------------------------------------------------------------
echo "Sunucuları sistem parametrelerini uygulamaya alıyorum."
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo sysctl --system
sleep 1

# Containerd konfigurasyonu için klasör oluşturup, varsayılan konfigurasyonu uyguluyoruz.
echo
echo -------------------------------------------------------------------------------------
echo "Containerd için klasör oluşturuyorum"
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo mkdir -p /etc/containerd
sleep 1
containerd config default | sudo tee /etc/containerd/config.toml

# Tüm node'larda swap'ı kapatıyoruz, Kubelet üzerinde çalıştığı Node'un bilgilerini anlık olarak controlplane'a iletebilmesi için swap kapatılmaktadır.
echo
echo -------------------------------------------------------------------------------------
echo "Swap'ı kapatıyorum (kalıcı olarak kapatmak için fstab'dan disable etmelisin)"
echo -------------------------------------------------------------------------------------
sleep 2
echo
sudo swapoff -a

echo -------------------------------------------------------------------------------------
echo "Kurulum İşlemlerini tamamladım, İyi günler dilerim"
echo -------------------------------------------------------------------------------------
sleep 2
