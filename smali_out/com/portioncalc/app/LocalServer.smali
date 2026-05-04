.class public Lcom/portioncalc/app/LocalServer;
.super Ljava/lang/Thread;
.source "LocalServer.java"

.field private final html:[B
.field private final wv:Landroid/webkit/WebView;

# Constructor stores bytes + WebView. No socket here — binding on main thread
# throws NetworkOnMainThreadException on Android. Socket is created in run().
.method public constructor <init>([BLandroid/webkit/WebView;)V
    .registers 4
    # p0=v1(this), p1=v2([B), p2=v3(WebView), v0=local bool

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V
    iput-object p1, p0, Lcom/portioncalc/app/LocalServer;->html:[B
    iput-object p2, p0, Lcom/portioncalc/app/LocalServer;->wv:Landroid/webkit/WebView;

    const/4 v0, 0x1
    invoke-virtual {p0, v0}, Ljava/lang/Thread;->setDaemon(Z)V

    return-void
.end method

# Background thread: bind socket, post loadUrl to UI thread, then serve forever.
.method public run()V
    .registers 11
    # p0=this, v0=ServerSocket, v1=Socket/temp, v2=InputStream/temp
    # v3=buf/length, v4=header, v5=OutputStream, v8=html, v9=WebView

    iget-object v8, p0, Lcom/portioncalc/app/LocalServer;->html:[B
    iget-object v9, p0, Lcom/portioncalc/app/LocalServer;->wv:Landroid/webkit/WebView;

    :try_start_bind
    new-instance v0, Ljava/net/ServerSocket;
    const/16 v1, 0x3039
    invoke-direct {v0, v1}, Ljava/net/ServerSocket;-><init>(I)V
    :try_end_bind
    .catch Ljava/lang/Exception; {:try_start_bind .. :try_end_bind} :catch_bind

    # Socket bound on background thread — post loadUrl to WebView UI thread.
    # View.post() queues the runnable even if the view isn't attached yet.
    new-instance v1, Lcom/portioncalc/app/LoadUrlRunnable;
    const-string v2, "http://localhost:12345/"
    invoke-direct {v1, v9, v2}, Lcom/portioncalc/app/LoadUrlRunnable;-><init>(Landroid/webkit/WebView;Ljava/lang/String;)V
    invoke-virtual {v9, v1}, Landroid/webkit/WebView;->post(Ljava/lang/Runnable;)Z

    :loop
    :try_start
    invoke-virtual {v0}, Ljava/net/ServerSocket;->accept()Ljava/net/Socket;
    move-result-object v1

    invoke-virtual {v1}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;
    move-result-object v2
    const/16 v3, 0x0400
    new-array v3, v3, [B
    invoke-virtual {v2, v3}, Ljava/io/InputStream;->read([B)I

    array-length v3, v8
    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
    const-string v5, "HTTP/1.0 200 OK\r\nContent-Type: text/html; charset=UTF-8\r\nContent-Length: "
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v5, "\r\n\r\n"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    const-string v5, "UTF-8"
    invoke-virtual {v4, v5}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    move-result-object v4

    invoke-virtual {v1}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;
    move-result-object v5
    invoke-virtual {v5, v4}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v5, v8}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v5}, Ljava/io/OutputStream;->flush()V
    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch

    goto :loop

    :catch
    goto :loop

    :catch_bind
    # Socket binding failed — fall back to file URL via UI thread post
    new-instance v1, Lcom/portioncalc/app/LoadUrlRunnable;
    const-string v2, "file:///android_asset/index.html"
    invoke-direct {v1, v9, v2}, Lcom/portioncalc/app/LoadUrlRunnable;-><init>(Landroid/webkit/WebView;Ljava/lang/String;)V
    invoke-virtual {v9, v1}, Landroid/webkit/WebView;->post(Ljava/lang/Runnable;)Z
    return-void
.end method
