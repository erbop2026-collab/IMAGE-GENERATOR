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
    .registers 5
    # v0=WebView, v1=WebSettings, v2=temp
    # p0=v3(this), p1=v4(Bundle)

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    new-instance v0, Landroid/webkit/WebView;
    invoke-direct {v0, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v0, p0, Lcom/portioncalc/app/MainActivity;->wv:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1

    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    # LOAD_NO_CACHE=2: always fetch from network, skip cache check (fixes ERR_CACHE_MISS)
    const/4 v2, 0x2
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setCacheMode(I)V

    const/4 v2, 0x0
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    new-instance v2, Landroid/webkit/WebViewClient;
    invoke-direct {v2}, Landroid/webkit/WebViewClient;-><init>()V
    invoke-virtual {v0, v2}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    new-instance v2, Landroid/webkit/WebChromeClient;
    invoke-direct {v2}, Landroid/webkit/WebChromeClient;-><init>()V
    invoke-virtual {v0, v2}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    # setContentView BEFORE loadUrl — WebView must be attached to window
    # before network requests can be made
    invoke-virtual {p0, v0}, Lcom/portioncalc/app/MainActivity;->setContentView(Landroid/view/View;)V

    const-string v2, "https://erbop2026-collab.github.io/IMAGE-GENERATOR/"
    invoke-virtual {v0, v2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    return-void
.end method
