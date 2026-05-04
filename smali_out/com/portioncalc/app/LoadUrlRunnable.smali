.class public Lcom/portioncalc/app/LoadUrlRunnable;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;
.source "LoadUrlRunnable.java"

.field private final wv:Landroid/webkit/WebView;
.field private final url:Ljava/lang/String;

.method public constructor <init>(Landroid/webkit/WebView;Ljava/lang/String;)V
    .registers 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/portioncalc/app/LoadUrlRunnable;->wv:Landroid/webkit/WebView;
    iput-object p2, p0, Lcom/portioncalc/app/LoadUrlRunnable;->url:Ljava/lang/String;
    return-void
.end method

.method public run()V
    .registers 3
    iget-object v0, p0, Lcom/portioncalc/app/LoadUrlRunnable;->wv:Landroid/webkit/WebView;
    iget-object v1, p0, Lcom/portioncalc/app/LoadUrlRunnable;->url:Ljava/lang/String;
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    return-void
.end method
