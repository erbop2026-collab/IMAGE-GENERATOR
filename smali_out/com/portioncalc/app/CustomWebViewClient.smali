.class public Lcom/portioncalc/app/CustomWebViewClient;
.super Landroid/webkit/WebViewClient;
.source "CustomWebViewClient.java"

# Serves index.html from memory for https://app.portioncalc.local/ requests.
# WebView treats intercepted HTTPS-scheme content as that origin, granting full
# outbound network access — the correct fix for Firestore from an APK asset.

.field private final html:[B

.method public constructor <init>([B)V
    .registers 3
    # 2 params: p0=v1(this), p1=v2([B), v0=unused local
    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V
    iput-object p1, p0, Lcom/portioncalc/app/CustomWebViewClient;->html:[B
    return-void
.end method

.method public shouldInterceptRequest(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Landroid/webkit/WebResourceResponse;
    .registers 8
    # 3 params: p0=v5(this), p1=v6(WebView), p2=v7(WebResourceRequest)
    # locals: v0-v4

    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;
    move-result-object v0
    invoke-virtual {v0}, Landroid/net/Uri;->getHost()Ljava/lang/String;
    move-result-object v0

    if-eqz v0, :passthrough

    const-string v1, "app.portioncalc.local"
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :passthrough

    iget-object v2, p0, Lcom/portioncalc/app/CustomWebViewClient;->html:[B

    new-instance v3, Ljava/io/ByteArrayInputStream;
    invoke-direct {v3, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    new-instance v4, Landroid/webkit/WebResourceResponse;
    const-string v0, "text/html"
    const-string v1, "UTF-8"
    invoke-direct {v4, v0, v1, v3}, Landroid/webkit/WebResourceResponse;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)V

    return-object v4

    :passthrough
    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->shouldInterceptRequest(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Landroid/webkit/WebResourceResponse;
    move-result-object v0
    return-object v0
.end method
