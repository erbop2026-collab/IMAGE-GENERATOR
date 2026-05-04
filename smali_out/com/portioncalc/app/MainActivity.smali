.class public Lcom/portioncalc/app/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


.field private wv:Landroid/webkit/WebView;


.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V
    return-void
.end method


.method public onBackPressed()V
    .registers 3

    iget-object v0, p0, Lcom/portioncalc/app/MainActivity;->wv:Landroid/webkit/WebView;
    if-eqz v0, :cond_e
    invoke-virtual {v0}, Landroid/webkit/WebView;->canGoBack()Z
    move-result v1
    if-eqz v1, :cond_e
    invoke-virtual {v0}, Landroid/webkit/WebView;->goBack()V
    return-void

    :cond_e
    invoke-super {p0}, Landroid/app/Activity;->onBackPressed()V
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .registers 11
    # v0=WebView, v1=WebSettings, v2=bool, v3=AssetManager/temp
    # v4=InputStream, v5=ByteArrayOutputStream, v6=buf→html, v7=n, v8=zero
    # p0=v9(this), p1=v10(Bundle)

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    new-instance v0, Landroid/webkit/WebView;
    invoke-direct {v0, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v0, p0, Lcom/portioncalc/app/MainActivity;->wv:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1

    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowContentAccess(Z)V

    const/4 v2, 0x0
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    # Read index.html bytes, wire CustomWebViewClient, load HTTPS origin URL.
    # shouldInterceptRequest serves bytes for app.portioncalc.local requests.
    # WebView grants full outbound HTTPS to content from an HTTPS-scheme origin.
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getAssets()Landroid/content/res/AssetManager;
    move-result-object v3

    const-string v4, "index.html"
    invoke-virtual {v3, v4}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;
    move-result-object v4

    new-instance v5, Ljava/io/ByteArrayOutputStream;
    invoke-direct {v5}, Ljava/io/ByteArrayOutputStream;-><init>()V

    const/16 v6, 0x2000
    new-array v6, v6, [B

    :read_loop
    invoke-virtual {v4, v6}, Ljava/io/InputStream;->read([B)I
    move-result v7
    if-ltz v7, :read_done
    const/4 v8, 0x0
    invoke-virtual {v5, v6, v8, v7}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    goto :read_loop

    :read_done
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    invoke-virtual {v5}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B
    move-result-object v6

    new-instance v3, Lcom/portioncalc/app/CustomWebViewClient;
    invoke-direct {v3, v6}, Lcom/portioncalc/app/CustomWebViewClient;-><init>([B)V
    invoke-virtual {v0, v3}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    new-instance v3, Landroid/webkit/WebChromeClient;
    invoke-direct {v3}, Landroid/webkit/WebChromeClient;-><init>()V
    invoke-virtual {v0, v3}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    const-string v3, "https://app.portioncalc.local/"
    invoke-virtual {v0, v3}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_fallback

    goto :after_load

    :catch_fallback
    new-instance v3, Landroid/webkit/WebViewClient;
    invoke-direct {v3}, Landroid/webkit/WebViewClient;-><init>()V
    invoke-virtual {v0, v3}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    const-string v3, "file:///android_asset/index.html"
    invoke-virtual {v0, v3}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :after_load
    invoke-virtual {p0, v0}, Lcom/portioncalc/app/MainActivity;->setContentView(Landroid/view/View;)V

    return-void
.end method
