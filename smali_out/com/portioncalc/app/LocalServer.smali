.class public Lcom/portioncalc/app/LocalServer;
.super Ljava/lang/Thread;
.source "LocalServer.java"

.field private final html:[B
.field private final ss:Ljava/net/ServerSocket;

# Constructor — binds port 12345 immediately so the port is ready
# before start() is called. Throws IOException if port is in use.
.method public constructor <init>([B)V
    .registers 4
    # p0=this, p1=byte[] html, v0=ServerSocket, v1=port

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    iput-object p1, p0, Lcom/portioncalc/app/LocalServer;->html:[B

    new-instance v0, Ljava/net/ServerSocket;
    const/16 v1, 0x3039
    invoke-direct {v0, v1}, Ljava/net/ServerSocket;-><init>(I)V
    iput-object v0, p0, Lcom/portioncalc/app/LocalServer;->ss:Ljava/net/ServerSocket;

    const/4 v0, 0x1
    invoke-virtual {p0, v0}, Ljava/lang/Thread;->setDaemon(Z)V

    return-void
.end method

# Serve html bytes for every incoming HTTP connection.
.method public run()V
    .registers 10
    # p0=this, v0=ServerSocket, v1=Socket, v2=InputStream
    # v3=buf/length, v4=StringBuilder/header_bytes, v5=string/OutputStream
    # v8=html bytes (stable across loop)

    iget-object v0, p0, Lcom/portioncalc/app/LocalServer;->ss:Ljava/net/ServerSocket;
    iget-object v8, p0, Lcom/portioncalc/app/LocalServer;->html:[B

    :loop
    :try_start
    invoke-virtual {v0}, Ljava/net/ServerSocket;->accept()Ljava/net/Socket;
    move-result-object v1

    # Drain the request headers
    invoke-virtual {v1}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;
    move-result-object v2
    const/16 v3, 0x0400
    new-array v3, v3, [B
    invoke-virtual {v2, v3}, Ljava/io/InputStream;->read([B)I

    # Build "HTTP/1.0 200 OK\r\nContent-Length: N\r\n\r\n" header
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

    # Write header + body
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
.end method
